using Godot;
using System;

[GlobalClass]
public partial class HudLayer : CanvasLayer
{
	
	public class FocusPoint {
		public IThing  Thing { get; set; }
		public Vector3 Point { get; set; }
		
		public FocusPoint(IThing thing, Vector3 point) {
			Thing = thing;
			Point = point;
		}
	};
	
	public const float INSPECT_DISTANCE = 65536;
	
	public FocusPoint Focus;
	
	Camera3D      Camera;
	RichTextLabel Inspect;
	Panel         Reticle;
	
	public override void _Ready()
	{
		Input.MouseMode = Input.MouseModeEnum.Hidden;
		Camera = GetNode("/root/Level/MainCamera") as Camera3D;
		Inspect = GetNode("./Inspect") as RichTextLabel;
		Reticle = GetNode("./Reticle") as Panel;
	}

	public override void _Process(double delta)
	{
	}
	
	void UpdateFocus() {
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
			Focus = null;
		} else {
			IThing  thing = result["collider"].As<Node3D>() as IThing;
			Vector3 point = result["position"].As<Vector3>();
			Focus  = new FocusPoint(thing,point);
		}
	}
	
	void SetInspectText(String text) {
		Inspect.Text = "[center]"+text+"[/center]";
	}
	
	void UpdateMouseReadout () {
		Vector2 mouse_position = GetViewport().GetMousePosition();
		Vector2 viewport_size = GetViewport().GetVisibleRect().Size;
		Reticle.Position = mouse_position;
		Inspect.Position = mouse_position-(mouse_position/viewport_size)*Inspect.Size;
		if ( (Focus != null) && (Focus.Thing != null )&& (Focus.Thing.Subject != null) ) {
			SetInspectText(Focus.Thing.Subject.Name);
		} else {
			SetInspectText("???");
		}
	}
	
	public override void _PhysicsProcess(double delta)
	{
		UpdateFocus();
		UpdateMouseReadout();
	}
}
