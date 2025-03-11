using Godot;
using System;

public partial class RigidThing : RigidBody3D, IThing
{
	
	[Export]
	public ThingSubject Subject { get; set; }
	
	[Export]
	public ThingContent Content { get; set; }
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		SetCollisionLayerValue(2,true);
		SetCollisionMaskValue (2,true);
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}
