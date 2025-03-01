using Godot;
using System;

public partial class Pal : RigidThing
{
	
	[Export]
	public Node3D Camera { get; set; } = null;
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}
	
	public Vector3 CalculateMovementForce(double delta)
	{
		// Get offset from camera
		Vector3 from_cam  = Transform.Origin - Camera.Transform.Origin;
		// Normalized vector pointing here from camera
		Vector3 away    = from_cam.Normalized();
		// Canonical 'up' vector
		Vector3 up      = new Vector3(0,1,0);
		// Canonical 'right' is perpandicular to up and away
		Vector3 right   = away.Cross(up);
		// Canonical 'forward' is perpandicular to up and right
		Vector3 forward = up.Cross(right);
		// Get distance to camera
		float dist      = from_cam.Length();
		Vector3 force   = new Vector3(0,0,0);
		if (Input.IsActionPressed("move_right")) {
			force += right;
		}
		if (Input.IsActionPressed("move_left")) {
			force -= right;
		}
		if (Input.IsActionPressed("move_forward")) {
			force += forward;
		}
		if (Input.IsActionPressed("move_backward")) {
			force -= forward;
		}
		return force.Normalized()*3.0f;
	}
	
	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		Vector3 movement_force = CalculateMovementForce(delta);
		float scale = (float)delta;
		ApplyCentralImpulse(movement_force*new Vector3(scale,scale,scale));
	}
	
}
