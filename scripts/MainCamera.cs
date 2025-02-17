using Godot;
using System;

public partial class MainCamera : Camera3D
{
	[Export]
	public Thing target { get; set; } = null;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		Transform = Transform.LookingAt(target.Transform.Origin);
	}
}
