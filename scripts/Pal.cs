using Godot;
using System;

public partial class Pal : Thing
{
	[Export]
	public Node3D Camera { get; set; } = null;
	
	[Export]
	public RigidBody3D RigidBody { get; set; } = null;
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		Vector3 to_cam  = Camera.Transform.Origin - Transform.Origin;
		Vector3 away    = to_cam.Normalized();
		Vector3 up      = new Vector3(0,1,0);
		Vector3 right   = away.Cross(up);
		Vector3 forward = up.Cross(right);
		float dist      = to_cam.Magnetude();
		Vector3 force   = new Vector3(0,0,0);
		if (Input.IsActionPressed("move_right")) {
			
		} else if (Input.IsActionPressed("move_right")) {
			
		} else if (Input.IsActionPressed("move_right")) {
			
		} else if (Input.IsActionPressed("move_right")) {
			
		}
		RigidBody.ApplyCentralImpulse(force*new Vec3(delta,delta,delta));
	}
	
}
