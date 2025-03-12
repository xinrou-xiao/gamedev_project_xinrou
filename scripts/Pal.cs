using Godot;
using System;


public partial class Pal : RigidThing
{
	
	HudLayer       HUD;
	RichTextLabel  DebugInfo;
	Camera3D       Camera;
	MeshInstance3D CoreMesh;
	SpotLight3D    SpotLight;
	
	[Export]
	public bool FacingFocus;
	
	Vector3 LastFacing = new Vector3(1,0,0);
	double  AverageFacingAngularVelocity = 0.0;
	

	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		RigidThingReady();
		DebugInfo = GetNode("/root/Level/HUDLayer/DebugInfo") as RichTextLabel;
		HUD       = GetNode("/root/Level/HUDLayer") as HudLayer;
		Camera    = GetNode("/root/Level/MainCamera") as Camera3D;
		CoreMesh  = GetNode("./CoreMesh") as MeshInstance3D;
		SpotLight = GetNode("./SpotLight") as SpotLight3D;
		FacingFocus = true;
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
		if ( HUD.Focus != null ) {
			DebugInfo.Text += HUD.Focus.Point.ToString();
		}
	}
	
	public void UpdateFacing(Vector3 facing, double delta) {
		bool exactly_up    = (Math.Abs(facing.Dot(new Vector3(0,1,0))) > 0.999);
		if (exactly_up) {
			return;
		}
		ShaderMaterial shader = CoreMesh.GetActiveMaterial(0) as ShaderMaterial;
		Transform3D facing_transform = (new Transform3D()).LookingAt(facing);
		shader.SetShaderParameter("facing",facing_transform);
		double dot_product  = Math.Min(1.0,facing.Dot(LastFacing));
		double angle_change = Math.Acos(dot_product);
		double angular_velocity = angle_change / delta;
		AverageFacingAngularVelocity = AverageFacingAngularVelocity*0.6 + angular_velocity*0.4;
		shader.SetShaderParameter("facing_angular_velocity",AverageFacingAngularVelocity);
		LastFacing = facing;
		SpotLight.Transform = facing_transform.Translated(Transform.Origin);
	}
	
	public void FaceTowardsMovement(double delta) {
		bool moving_substantially = (LinearVelocity.Length() > 0.001);
		if (moving_substantially) {
			UpdateFacing(LinearVelocity.Normalized(),delta);
		}
	}
	
	public void FaceTowardsFocus(double delta) {
		if ( HUD.Focus != null ) {
			Vector3 point = HUD.Focus.Point;
			Vector3 facing_towards_focus = (point - Transform.Origin).Normalized();
			UpdateFacing(facing_towards_focus,delta);
		}
	}
	
	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		Vector3 movement_force = CalculateMovementForce(delta);
		float scale = (float)delta;
		ApplyCentralImpulse(movement_force*new Vector3(scale,scale,scale));
		if (FacingFocus) {
			FaceTowardsFocus(delta);
		} else {
			FaceTowardsMovement(delta);
		}
		UpdateDebugInfo();
	}
	
}
