within Buildings.Experimental.DHC.Loads.Heating.DHW.Examples;
model DomesticWaterHeaterAndFixture
  "Example implementation of direct district heat exchange and auxiliary line heater for DHW"
  extends Modelica.Icons.Example;
  replaceable package Medium = Buildings.Media.Water "Water media model";
  parameter Modelica.Units.SI.Temperature TSetHw = 273.15+50 "Temperature setpoint of hot water supply from heater";
  parameter Modelica.Units.SI.Temperature TDHw = 273.15+45 "Temperature setpoint of hot water supply from district";
  parameter Modelica.Units.SI.Temperature TSetTw = 273.15+43 "Temperature setpoint of tempered water supply at fixture";
  parameter Modelica.Units.SI.Temperature TDcw = 273.15+10 "Temperature setpoint of domestic cold water supply";
  parameter Modelica.Units.SI.MassFlowRate mHw_flow_nominal = 0.1 "Nominal mass flow rate of hot water supply";
  parameter Modelica.Units.SI.MassFlowRate mDH_flow_nominal = 1 "Nominal mass flow rate of district heating water";
  parameter Modelica.Units.SI.MassFlowRate mDhw_flow_nominal = mHw_flow_nominal "Nominal mass flow rate of tempered water";
  parameter Modelica.Units.SI.PressureDifference dpValve_nominal(min=0, displayUnit="Pa") "Pressure difference";
  parameter Real kCon(min=0) = 2 "Gain of controller";
  parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 15 "Time constant of Integrator block";
  parameter Real uLow = 0.1 "low hysteresis threshold";
  parameter Real uHigh = 0.9 "high hysteresis threshold";
  parameter Boolean havePEle = datGenDHW.havePEle "Flag that specifies whether electric power is required for water heating";

  Buildings.Fluid.Sources.Boundary_pT souDcw(
    redeclare package Medium = Medium,
    T(displayUnit = "degC") = TDcw,
    nPorts=2) "Source of domestic cold water"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-50})));
  HeatPumpWaterHeaterWithTank genDHW(
    redeclare package Medium = Medium,
    havePEle=havePEle,
    mHw_flow_nominal=mHw_flow_nominal,
    mDH_flow_nominal=mDH_flow_nominal,
    QCon_flow_max = datGenDHW.QCon_flow_max,
    QCon_flow_nominal=datGenDHW.QCon_flow_nominal,
    VTan=datGenDHW.VTan,
    hTan=datGenDHW.hTan,
    dIns=datGenDHW.dIns,
    kIns=datGenDHW.kIns,
    QTan_flow_nominal = datGenDHW.QTan_flow_nominal,
    hHex_a = datGenDHW.hHex_a,
    hHex_b = datGenDHW.hHex_b,
    mHex_flow_nominal = datGenDHW.mHex_flow_nominal,
    TTan_nominal = datGenDHW.TTan_nominal,
    THex_nominal = datGenDHW.THex_nominal,
    dpHex_nominal = datGenDHW.dpHex_nominal,
    nSeg=datGenDHW.nSeg,
    dTEva_nominal=datGenDHW.dTEva_nominal,
    dTCon_nominal=datGenDHW.dTCon_nominal)   "Generation of DHW"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  DomesticWaterMixer tmv(
    redeclare package Medium = Medium,
    TSet(displayUnit="degC") = TSetTw,
    mDhw_flow_nominal=mDhw_flow_nominal,
    dpValve_nominal=dpValve_nominal,
    k=kCon,
    uLow=uLow,
    uHigh=uHigh,
    Ti=Ti) "Ideal thermostatic mixing valve"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Interfaces.RealOutput TTw(final unit="K",displayUnit = "degC") "Temperature of the outlet tempered water"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Fluid.Sources.Boundary_pT souDHw(
    redeclare package Medium = Medium,
    T(displayUnit = "degC") = TDHw,
    nPorts=1) "Source of district hot water" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,-50})));
  Fluid.Sources.MassFlowSource_T sinDHw(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    nPorts=1) "Sink for district heating water"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,-50})));
  Modelica.Blocks.Sources.Constant const(k=-1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-90,-90})));
  Modelica.Blocks.Sources.Constant conTSetHw(k=TSetHw)
    "Temperature setpoint for domestic hot water supply from heater"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Interfaces.RealOutput PEle if havePEle == true
    "Electric power required for generation equipment"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  DHWLoad loaDHW(redeclare package Medium = Medium, mDhw_flow_nominal=
        mDhw_flow_nominal) "load for DHW"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Interfaces.RealOutput mDhw "Total hot water consumption"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}}),
        iconTransformation(extent={{100,-70},{120,-50}})));
  replaceable Data.HeatPumpWaterHeater datGenDHW
    annotation (Placement(transformation(extent={{-98,82},{-82,98}})));
  Modelica.Blocks.Sources.CombiTimeTable schDhw(
    tableOnFile=true,
    tableName="tab1",
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/Data/Experimental/DHC/Loads/Heating/DHW/DHW_SingleApartment.mos"),

    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic) "Domestic hot water fraction schedule"
    annotation (Placement(transformation(extent={{100,20},{80,40}})));
equation
  connect(tmv.TTw, TTw)
    annotation (Line(points={{21,6},{30,6},{30,60},{110,60}},color={0,0,127}));
  connect(const.y, sinDHw.m_flow_in)
    annotation (Line(points={{-90,-79},{-90,-70},{-78,-70},{-78,-62}},
                                                          color={0,0,127}));
  connect(conTSetHw.y, genDHW.TSetHw)
    annotation (Line(points={{-79,0},{-41,0}}, color={0,0,127}));
  connect(genDHW.PEle, PEle) annotation (Line(points={{-19,0},{-10,0},{-10,80},
          {110,80}}, color={0,0,127}));
  connect(genDHW.port_b1, tmv.port_hw)
    annotation (Line(points={{-20,6},{0,6}}, color={0,127,255}));
  connect(souDHw.ports[1], genDHW.port_a2) annotation (Line(points={{10,-40},{
          10,-20},{-14,-20},{-14,-6},{-20,-6}}, color={0,127,255}));
  connect(genDHW.port_b2, sinDHw.ports[1])
    annotation (Line(points={{-40,-6},{-70,-6},{-70,-40}}, color={0,127,255}));
  connect(souDcw.ports[1], tmv.port_cw) annotation (Line(points={{-29,-40},{-29,
          -30},{-6,-30},{-6,-6},{0,-6}}, color={0,127,255}));
  connect(souDcw.ports[2], genDHW.port_a1) annotation (Line(points={{-31,-40},{
          -31,-30},{-50,-30},{-50,6},{-40,6}}, color={0,127,255}));
  connect(tmv.port_tw, loaDHW.port_tw)
    annotation (Line(points={{20,0},{40,0}}, color={0,127,255}));
  connect(loaDHW.mDhw, mDhw) annotation (Line(points={{61,-8},{80,-8},{80,-60},
          {110,-60}}, color={0,0,127}));
  connect(loaDHW.schDhw, schDhw.y[1])
    annotation (Line(points={{61,2},{74,2},{74,30},{79,30}}, color={0,0,127}));
  annotation (preferredView="info",Documentation(info="<html>
<p>
This is an example of a domestic water heater and fixture.
</p>
</html>", revisions="<html>
<ul>
<li>
October 20, 2022 by Dre Helmns:<br/>
Created example.
</li>
</ul>
</html>"),experiment(StopTime=3600, Interval=1));
end DomesticWaterHeaterAndFixture;
