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
			float correction = 0;
			if (current_dist > tether_max) {
				correction = 1-(tether_max/current_dist);
			}
			else if (current_dist < tether_min) {
				correction = 1-(tether_min/current_dist);
			}
			Vector3 destination = Transform.Origin.Lerp(
				target.Transform.Origin,
				correction
			);
			float s = 1-1/(float) Math.Pow(Math.E,tether_lerp*(float)delta);
			Vector3 scale  = new Vector3 (s,s,s);
			Vector3 offset = (destination - Transform.Origin) * scale;
			Transform = Transform.Translated(offset);
		}
	}
}
