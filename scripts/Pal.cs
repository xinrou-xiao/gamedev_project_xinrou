using Godot;
using System;


public partial class Pal : RigidThing
{
	
	[Export]
	public Camera3D Camera { get; set; } = null;
	
	Vector3 LastFacing = new Vector3(1,0,0);
	double  AverageFacingAngularVelocity = 0.0;
	
	MeshInstance3D CoreMesh;
	
	RichTextLabel DebugInfo;
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		CoreMesh = FindChild("CoreMesh") as MeshInstance3D;
		DebugInfo = GetNode("/root/Level/HUDLayer/DebugInfo") as RichTextLabel;
		Camera    = GetNode("/root/Level/MainCamera") as Camera3D;
		Subject = new ThingSubject();
		Subject.Name = "Pal";
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
	
	public void UpdateDebugInfo()
	{
		DebugInfo.Text = Transform.Origin.ToString();
	}
	
	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		Vector3 movement_force = CalculateMovementForce(delta);
		float scale = (float)delta;
		ApplyCentralImpulse(movement_force*new Vector3(scale,scale,scale));
		bool moving_substantially = (LinearVelocity.Length() > 0.001);
		bool moving_exactly_up    = (Math.Abs(LinearVelocity.Normalized().Dot(new Vector3(0,1,0))) > 0.999);
		if (moving_substantially && !moving_exactly_up){
			Vector3 facing = LinearVelocity.Normalized();
			ShaderMaterial shader = CoreMesh.GetActiveMaterial(0) as ShaderMaterial;
			shader.SetShaderParameter("facing",(new Transform3D()).LookingAt(LinearVelocity));
			double dot_product  = Math.Min(1.0,facing.Dot(LastFacing));
			double angle_change = Math.Acos(dot_product);
			double angular_velocity = angle_change / delta;
			AverageFacingAngularVelocity = AverageFacingAngularVelocity*0.6 + angular_velocity*0.4;
			shader.SetShaderParameter("facing_angular_velocity",AverageFacingAngularVelocity);
			LastFacing = facing;
		}
		
		UpdateDebugInfo();
	}
	
}
