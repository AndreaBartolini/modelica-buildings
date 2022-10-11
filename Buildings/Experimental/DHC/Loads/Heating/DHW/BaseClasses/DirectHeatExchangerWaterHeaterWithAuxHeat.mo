within Buildings.Experimental.DHC.Loads.Heating.DHW.BaseClasses;
model DirectHeatExchangerWaterHeaterWithAuxHeat
  "A model for domestic water heating served by district heat exchanger and supplemental electric resistance"
  extends
    Buildings.Experimental.DHC.Loads.Heating.DHW.BaseClasses.PartialFourPortDHW;

  Buildings.Fluid.HeatExchangers.Heater_T heaDhw(
    redeclare package Medium = Medium,
    m_flow_nominal=mHw_flow_nominal,
    dp_nominal=0) if havePEle == true
                  "Supplemental electric resistance domestic hot water heater"
    annotation (Placement(transformation(extent={{10,16},{30,-4}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemAuxHeaOut(redeclare package
              Medium = Medium, m_flow_nominal=mHw_flow_nominal)
    annotation (Placement(transformation(extent={{60,-4},{80,16}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    m1_flow_nominal=mHw_flow_nominal,
    m2_flow_nominal=mDH_flow_nominal,
    dp1_nominal=0,
    dp2_nominal=0,
    eps=0.85) "Domestic hot water heater"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Fluid.Sensors.TemperatureTwoPort senTemHXOut(redeclare package Medium =
        Medium, m_flow_nominal=mHw_flow_nominal)
    annotation (Placement(transformation(extent={{-40,-4},{-20,16}})));
protected
  Fluid.FixedResistances.LosslessPipe pip(
    redeclare final package Medium = Medium,
    final m_flow_nominal=mHw_flow_nominal,
    final show_T=false) if havePEle == false "Pipe without electric resistance"
    annotation (Placement(transformation(extent={{10,44},{30,24}})));

equation
  connect(senTemHXOut.port_a, hex.port_b1)
    annotation (Line(points={{-40,6},{-60,6}}, color={0,127,255}));
  connect(senTemHXOut.port_b, heaDhw.port_a)
    annotation (Line(points={{-20,6},{10,6}},color={0,127,255}));
  connect(senTemHXOut.port_b, pip.port_a) annotation (Line(points={{-20,6},{-4,6},
          {-4,34},{10,34}},  color={0,127,255}));
  connect(heaDhw.port_b, senTemAuxHeaOut.port_a)
    annotation (Line(points={{30,6},{60,6}}, color={0,127,255}));
  connect(pip.port_b, senTemAuxHeaOut.port_a) annotation (Line(points={{30,34},{
          44,34},{44,6},{60,6}},   color={0,127,255}));
  connect(senTemAuxHeaOut.port_b, port_b1) annotation (Line(points={{80,6},{90,6},
          {90,60},{100,60}}, color={0,127,255}));
  connect(port_a1, hex.port_a1)
    annotation (Line(points={{-100,60},{-80,60},{-80,6}}, color={0,127,255}));
  connect(heaDhw.Q_flow, PEle) annotation (Line(points={{31,-2},{40,-2},{40,-20},
          {94,-20},{94,0},{110,0}}, color={0,0,127}));
  connect(TSetHw, heaDhw.TSet) annotation (Line(points={{-110,0},{-90,0},{-90,-20},
          {0,-20},{0,-2},{8,-2}}, color={0,0,127}));
  connect(hex.port_b2, port_b2) annotation (Line(points={{-80,-6},{-80,-60},{-100,
          -60}}, color={0,127,255}));
  connect(port_a2, hex.port_a2) annotation (Line(points={{100,-60},{-60,-60},{-60,
          -6}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid)}),                        Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DirectHeatExchangerWaterHeaterWithAuxHeat;
