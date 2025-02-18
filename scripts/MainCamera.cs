using Godot;
using System;

public partial class MainCamera : Camera3D
{
	[Export]
	public Node3D target { get; set; } = null;
	
	[Export]
	public Node3D anchor { get; set; } = null;
	
	[Export]
	public float tether_min { get; set; } = 0;
	
	[Export]
	public float tether_max { get; set; } = 0;
	
	[Export]
	public float tether_lerp { get; set; } = 0;
	

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		if (target != null) {
			Transform = Transform.LookingAt(target.Transform.Origin);
		}
		if (anchor != null) {
			float current_dist = Transform.Origin.DistanceTo(anchor.Transform.Origin);
			float coeff = 0;
			if (current_dist > tether_max) {
				coeff = 1; 
			}
			else if (current_dist < tether_min) {
				coeff = -1;
			}
			float t = 1 - 1/(float)Math.Pow(Math.E,(float)delta*tether_lerp);
			Vector3 destination = Transform.Origin.Lerp(
				anchor.Transform.Origin,
				t*coeff
			);
			Vector3 offset = destination - Transform.Origin;
			Transform = Transform.Translated(offset);
		}
	}
}
