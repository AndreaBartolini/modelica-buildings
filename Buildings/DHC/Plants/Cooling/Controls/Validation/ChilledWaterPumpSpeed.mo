within Buildings.DHC.Plants.Cooling.Controls.Validation;
model ChilledWaterPumpSpeed
  "Example to test the chilled water pump speed controller"
  extends Modelica.Icons.Example;
  Buildings.DHC.Plants.Cooling.Controls.ChilledWaterPumpSpeed chiWatPumSpe(
    dpSetPoi=68900,
    tWai=30,
    m_flow_nominal=0.5,
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    k=1,
    Ti=60,
    Td=0.1)
    "Chilled water pump speed controller"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Pulse mFloTot(
    amplitude=2*chiWatPumSpe.m_flow_nominal,
    period=300,
    shift=150)
    "Total chilled water mass flow rate"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Pulse dpMea(
    amplitude=0.4*chiWatPumSpe.dpSetPoi,
    period=150,
    shift=150,
    offset=0.8*chiWatPumSpe.dpSetPoi)
    "Measured pressure drop"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant on(k=true)
    "Plant on signal"
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
equation
  connect(mFloTot.y,chiWatPumSpe.masFloPum)
    annotation (Line(points={{-38,30},{-30,30},{-30,2},{-12,2}},
      color={0,0,127}));
  connect(dpMea.y, chiWatPumSpe.dpMea) annotation (Line(points={{-38,-30},{-30,-30},
          {-30,-4},{-12,-4}}, color={0,0,127}));
  connect(on.y, chiWatPumSpe.on) annotation (Line(points={{-38,70},{-20,70},{-20,
          8},{-12,8}}, color={255,0,255}));
  annotation (
    Icon(
      coordinateSystem(
        preserveAspectRatio=false)),
    Diagram(
      coordinateSystem(
        preserveAspectRatio=false)),
    experiment(
      StopTime=1200,
      Tolerance=1e-06),
    __Dymola_Commands(
      file="modelica://Buildings/Resources/Scripts/Dymola/DHC/Plants/Cooling/Controls/Validation/ChilledWaterPumpSpeed.mos"
      "Simulate and Plot"),
    Documentation(
      revisions="<html>
<ul>
<li>
December 14, 2022 by Kathryn Hinkelman:<br>
Revised <code>dpMea</code> input from constant to step function.
</li>
<li>
August 6, 2020 by Jing Wang:<br/>
First implementation.
</li>
</ul>
</html>",
      info="<html>
<p>This model validates the variable speed pump control logic implemented in
<a href=\"modelica://Buildings.DHC.Plants.Cooling.Controls.ChilledWaterPumpSpeed\">
Buildings.DHC.Plants.Cooling.Controls.ChilledWaterPumpSpeed</a>.
</p>
</html>"));
end ChilledWaterPumpSpeed;
