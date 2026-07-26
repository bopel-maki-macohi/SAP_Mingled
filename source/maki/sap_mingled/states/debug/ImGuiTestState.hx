package maki.sap_mingled.states.debug;

import imgui.ImGui;

class ImGuiTestState extends SAPState
{
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		ImGui.begin('Hello');

		ImGui.end();
	}
}
