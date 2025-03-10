using Godot;
using System;

public partial class HudLayer : CanvasLayer
{
	public const float INSPECT_DISTANCE = 65536;
	
	Camera3D Camera;
	Label    Inspect;
	
	public override void _Ready()
	{
		Camera = GetNode("/root/Level/MainCamera") as Camera3D;
		Inspect = FindChild("Inspect") as Label;
		Inspect.Text = "!!!";
	}

	public override void _Process(double delta)
	{
	}
	
	public override void _PhysicsProcess(double delta)
	{
		PhysicsDirectSpaceState3D space_state = Camera.GetWorld3D().DirectSpaceState;
		Vector2 mouse_position = GetViewport().GetMousePosition();
		Vector3 origin = Camera.ProjectRayOrigin(mouse_position);
		Vector3 inspect_scale = new Vector3(
			INSPECT_DISTANCE,
			INSPECT_DISTANCE,
			INSPECT_DISTANCE
		);
		Vector3 end = origin + Camera.ProjectRayNormal(mouse_position) * inspect_scale;
		PhysicsRayQueryParameters3D query = PhysicsRayQueryParameters3D.Create(
			origin, end, ThingSubject.INSPECTION_LAYER
		);
		Godot.Collections.Dictionary result = space_state.IntersectRay(query);
		if (!result.ContainsKey("collider")) {
			Inspect.Text = "///";
		}
		IThing thing = result["collider"].As<Node3D>() as IThing;
		if(thing.Subject == null) {
			Inspect.Text = thing.Subject.Name;
		} else {
			Inspect.Text = "???";
		}
		
	}
}
