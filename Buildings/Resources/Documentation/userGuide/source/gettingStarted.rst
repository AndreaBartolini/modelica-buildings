.. highlight:: rest

.. _gettingStarted:

Getting Started
===============


Literature for Users
--------------------
The following books are useful for new users to get started:

* The online book with interactive examples of Michael Tiller at https://mbe.modelica.university/.
* The books by Michael Tiller [Til2001]_ and Peter Fritzson ([Fri2011]_ and [Fri2004]_).
* The tutorials that are listed at https://modelica.org/publications.

Although the `Modelica Language Tutorial <https://modelica.org/documents/ModelicaTutorial14.pdf>`_ is for an older version (Modelica 1.4), it is still instructive and relevant to understand the concepts of the language.

Links to papers that describe or used the `Buildings` library are available at https://simulationresearch.lbl.gov/modelica/publications.html.
The model documentation from the download page contains user guides that describe the individual packages of the `Buildings` library.

The `IEA EBC Annex 60 <https://www.iea-annex60.org/final-report.html>`_ final report
summarizes the development of Modelica models, approaches and tools
for co-simulation based on the Functional Mockup Interface standard,
Building Information Modeling technologies based on the Industry Foundation Classes,
as well as tools for workflow automation.
It also contains numerous examples that apply these technologies to the
design and operation of building and community energy systems.


Spoken tutorials for beginners are available at https://spoken-tutorial.org/tutorial-search/?search_foss=OpenModelica&search_language=English.


Running the First Simulations
-----------------------------

To start using Modelica, run some of the example models of the `Buildings` library.
Make variations in these examples by changing values of model parameters
or by replacing existing component models by new ones.
The example models can be found in the packages `Examples`.

Study the detailed tutorials with step-by-step instructions for how to build system models,
which can be found in the `Tutorial package <https://simulationresearch.lbl.gov/modelica/releases/v9.1.1/help/Buildings_Examples_Tutorial.html>`_.

Note that heat transfer models, which can be found in `Buildings.HeatTransfer.*.Examples`
are easier to understand than fluid flow models because;

* handling fluid flow adds more complexity due to flow reversal (i.e., if the mass flow rate changes its direction),
* fluid flow models may need to handle multiple species such as air and water vapor, as well as trace substances such as CO2, and
* fluid flow models use packages that define medium models, such as dry air, moist air, water or other fluids.

To get started with Spawn of EnergyPlus, we recommend to first familiarize yourself with Modelica, as described above.
Next, read the
`user guide for the Spawn models <https://simulationresearch.lbl.gov/modelica/releases/v9.1.1/help/Buildings_ThermalZones_EnergyPlus_9_6_0_UsersGuide.html>`_
which provides step-by-step instructions and points to various examples.


Software Requirements
---------------------

Check the software requirements for the different versions of the Buildings library at https://simulationresearch.lbl.gov/modelica/download.html


Literature for Developers
-------------------------

It is essential that users who develop new thermo-fluid models to understand the concept of stream connectors.
Stream connectors are explained in the Modelica language definition, available at https://modelica.org/documents,
and in the paper Franke et al. [Fra2009a]_.
The `Buildings` library uses similar modeling principles, and the same base classes, as the `Modelica.Fluid` library.
Hence, we also recommend reading the paper about the standardization of thermo-fluid models in Modelica.Fluid [Fra2009b]_.

The `Modelica Web Reference <https://webref.modelica.university>`_ gives a concise overview, explanation and further links about the Modelica language.

See :numref:`sec_sty_gui` for conventions and guidelines of the `Buildings` library.


References
----------

.. [Fri2004] Peter Fritzson. *Principles of Object-Oriented Modeling and Simulation with Modelica 2.1.* John Wiley & Sons, 2004.

.. [Fri2011] Peter Fritzson. *Introduction to Modeling and Simulation of Technical and Physical Systems with Modelica.* Wiley-IEEE Press, ISBN 978-1-1180-1068-6, 2011.

.. [Fra2009a] R. Franke, F. Casella, M. Otter, M. Sielemann, H. Elmqvist, S. E. Mattsson, and H. Olsson.
              `Stream connectors – an extension of modelica for device-oriented modeling of convective transport phenomena <http://dx.doi.org/10.3384/ecp09430078>`_.
              In F. Casella, editor, Proc. of the 7-th International Modelica Conference, Como, Italy, Sept. 2009.

.. [Fra2009b] R. Franke, F. Casella, M. Otter, K. Proelss, M. Sielemann, and M. Wetter. `Standardization of thermo-fluid modeling in Modelica.Fluid
              <http://dx.doi.org/10.3384/ecp09430077>`_.
              In F. Casella, editor, Proc. of the 7-th International Modelica Conference, Como, Italy, Sept. 2009.

.. [Til2001] Michael M. Tiller. *Introduction to Physical Modeling with Modelica.* Kluwer Academic Publisher, 2001.
