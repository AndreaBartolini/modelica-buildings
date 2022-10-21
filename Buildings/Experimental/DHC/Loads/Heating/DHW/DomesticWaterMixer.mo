within Buildings.Experimental.DHC.Loads.Heating.DHW;
model DomesticWaterMixer "A model for a domestic water mixer"
  replaceable package Medium = Buildings.Media.Water "Water media model";
  parameter Modelica.Units.SI.Temperature TSet = 273.15+40 "Temperature setpoint of tempered hot water outlet";
  parameter Modelica.Units.SI.MassFlowRate mDhw_flow_nominal "Nominal doemstic hot water flow rate";
  parameter Modelica.Units.SI.PressureDifference dpValve_nominal(min=0, displayUnit="Pa") "Pressure difference";
  parameter Real k(min=0) = 2 "Gain of controller";
  parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 15 "Time constant of Integrator block" annotation (Dialog(enable=
          conPID.controllerType == Modelica.Blocks.Types.SimpleController.PI or
          conPID.controllerType == Modelica.Blocks.Types.SimpleController.PID));
  Modelica.Fluid.Interfaces.FluidPort_b port_tw(redeclare package Medium =
        Medium) "Port for tempered water outlet"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k,
    Ti=Ti,
    reset=Buildings.Types.Reset.Parameter)
    annotation (Placement(transformation(extent={{40,60},{20,80}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemTw(redeclare package Medium
      = Medium, m_flow_nominal=mDhw_flow_nominal) "Tempered water temperature sensor"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.Constant conTSetCon(k=TSet) "Temperature setpoint for domestic tempered water supply to consumer"
    annotation (Placement(transformation(extent={{80,60},{60,80}})));
  Fluid.Actuators.Valves.ThreeWayLinear
             ideValHea(redeclare package Medium = Medium, final m_flow_nominal=
        mDhw_flow_nominal,
    dpValve_nominal=dpValve_nominal)
                           "Ideal valve" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={0,0})));
  Modelica.Fluid.Interfaces.FluidPort_a port_hw(redeclare package Medium =
        Medium) "Port for hot water supply"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_cw(redeclare package Medium =
        Medium) "Port for domestic cold water supply"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Blocks.Interfaces.RealOutput TTw "Temperature of the outlet tempered water"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemHw(redeclare package Medium
      = Medium, m_flow_nominal=mDhw_flow_nominal) "Hot water temperature sensor"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemCw(redeclare package Medium
      = Medium, m_flow_nominal=mDhw_flow_nominal) "Cold water temperature sensor"
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  Buildings.Fluid.Sensors.MassFlowRate senFloDhw(redeclare package Medium =
        Medium) "Mass flow rate of domestic hot water"
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
    annotation (Placement(transformation(extent={{54,22},{44,32}})));
equation
  connect(conTSetCon.y, conPID.u_s)
    annotation (Line(points={{59,70},{42,70}}, color={0,0,127}));
  connect(senTemTw.T, conPID.u_m)
    annotation (Line(points={{30,11},{30,58}}, color={0,0,127}));
  connect(ideValHea.port_2, senTemTw.port_a) annotation (Line(points={{10,-6.66134e-16},
          {20,-6.66134e-16},{20,0}}, color={0,127,255}));
  connect(conPID.y, ideValHea.y) annotation (Line(points={{19,70},{0,70},{0,12},
          {9.99201e-16,12}},color={0,0,127}));
  connect(senTemTw.T, TTw) annotation (Line(points={{30,11},{30,30},{34,30},{34,
          40},{96,40},{96,60},{110,60}},
                         color={0,0,127}));
  connect(ideValHea.port_1, senTemHw.port_b)
    annotation (Line(points={{-10,1.77636e-15},{-10,0},{-20,0}},
                                                color={0,127,255}));
  connect(senTemHw.port_a, port_hw) annotation (Line(points={{-40,0},{-54,0},{-54,
          60},{-100,60}}, color={0,127,255}));
  connect(ideValHea.port_3, senTemCw.port_b)
    annotation (Line(points={{-1.77636e-15,-10},{-1.77636e-15,-60},{-20,-60}},
                                                        color={0,127,255}));
  connect(senTemCw.port_a, port_cw)
    annotation (Line(points={{-40,-60},{-100,-60}}, color={0,127,255}));
  connect(senTemTw.port_b, senFloDhw.port_a)
    annotation (Line(points={{40,0},{50,0}}, color={0,127,255}));
  connect(senFloDhw.port_b, port_tw)
    annotation (Line(points={{70,0},{100,0}}, color={0,127,255}));
  connect(greaterThreshold.u, senFloDhw.m_flow)
    annotation (Line(points={{55,27},{60,27},{60,11}}, color={0,0,127}));
  connect(greaterThreshold.y, conPID.trigger)
    annotation (Line(points={{43.5,27},{38,27},{38,58}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Rectangle(
          visible=use_inputFilter,
          extent={{-34,-28},{32,32}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Ellipse(
          visible=use_inputFilter,
          extent={{-34,32},{32,-28}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          visible=use_inputFilter,
          extent={{-22,26},{20,-20}},
          textColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="M",
          textStyle={TextStyle.Bold}),
        Text(
          extent={{-42,58},{-162,8}},
          textColor={0,0,0},
          textString=DynamicSelect("", String(y, format=".2f"))),
    Rectangle(
      extent={{-40,22},{40,-22}},
      lineColor={0,0,0},
      fillPattern=FillPattern.VerticalCylinder,
      fillColor={192,192,192},
          origin={-78,60},
          rotation=90),
    Rectangle(
      extent={{-22,22},{22,-22}},
      lineColor={0,0,0},
      fillPattern=FillPattern.VerticalCylinder,
      fillColor={238,46,47},
          origin={-78,60},
          rotation=90),
    Line(
      visible=use_inputFilter,
      points={{-32,-28},{28,-28}}),
    Rectangle(
      extent={{-40,22},{40,-22}},
      lineColor={0,0,0},
      fillPattern=FillPattern.VerticalCylinder,
      fillColor={192,192,192},
          origin={-78,-60},
          rotation=90),
    Rectangle(
      extent={{-22,22},{22,-22}},
      lineColor={0,0,0},
      fillPattern=FillPattern.VerticalCylinder,
      fillColor={28,108,200},
          origin={-78,-60},
          rotation=90),
    Rectangle(
      extent={{-40,22},{40,-22}},
      lineColor={0,0,0},
      fillPattern=FillPattern.VerticalCylinder,
      fillColor={192,192,192},
          origin={78,0},
          rotation=90),
    Rectangle(
      extent={{-22,22},{22,-22}},
      lineColor={0,0,0},
      fillPattern=FillPattern.VerticalCylinder,
      fillColor={102,44,145},
          origin={78,0},
          rotation=90),
      Text(
          extent={{-153,147},{147,107}},
          textColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DomesticWaterMixer;
