# PertyFish - A Chess Game w/ built-in chess engine Power Apps Canvas App written entirely in PowerFx

This project is a Chess Game written entirely in PowerFx (the low code language using in Power Apps development). This project was created by the author as a fun way to learn how to create a Power App Canvas Application. The game supports human vs. human play, human vs. computer (the built in chess engine logic), and computer vs. computer (i.e., it can play against itself). The goal of the project is NOT to create a powerful chess game/engine, but rather to create one that works, is fully functional, and written entirely using low code. PertyFish only allows legal chess moves, including the tricky stuff like castling, en passant captures, and pawn promotions.

## Project Status

This is the author's first open source project and therefore the first attempt at managing an OSS project. At this time the author is the only contributor and is in the process of learning lots of new things Github related. Additional contributors are welcome however be warned that the author is new at all of this OSS, Github, and Power App technologies, so please be patient. The author works on this project as a hobby, and has generally adds code checks project status at least monthly (usually weekly).


https://github.com/pnp/powerapps-samples/tree/main
https://github.com/pnp/powerapps-samples/blob/main/samples/power-wordle-game/README.md





## Table of Contents

- Project Status
- Installation
- Contributing
- License
- Acknowledgements

## Installation
You can also use the [Power Apps Source Code tool](https://github.com/microsoft/PowerApps-Language-Tooling) to the code using these steps:

* Clone the repository to a local drive
* Pack the source files back into `.msapp` file:
  * [Power Apps Tooling Usage](https://github.com/microsoft/PowerApps-Language-Tooling)
* Within **Power Apps Studio**, use the `.msapp` file using **File** > **Open** > **Browse** and select the `.msapp` file you just packed.



1. Project Title
Start with the name of your project. Make it clear and concise.

2. Description
Provide a brief description of what your project does and why it is useful. This should be a few sentences to a paragraph.

3. Table of Contents
Include a table of contents to help users navigate your README file easily.

4. Installation
Explain how to install and set up your project. Include any prerequisites and step-by-step instructions.

5. Usage
Show how to use your project with examples. This can include code snippets and screenshots.

6. Contributing
Encourage others to contribute to your project. Provide guidelines on how to do so, including how to submit issues and pull requests.

7. License
Specify the license under which your project is distributed. This is important for legal reasons.

8. Acknowledgements
Give credit to those who have helped or inspired you in your project.



You can also use the [Power Apps CLI](https://docs.microsoft.com/powerapps/developer/data-platform/powerapps-cli) to pack the source code by following these steps::

* Clone the repository to a local drive
* Pack the source files back into `.msapp` file:
  ```bash
  pac canvas pack --sources pathtosourcefolder --msapp pathtomsapp
  ```
  Making sure to replace `pathtosourcefolder` to point to the path to this sample's `sourcecode` folder, and `pathtomsapp` to point to the path of this solution's `.msapp` file (located under the `solution` folder)
* Use the `.msapp` file using **File** > **Open** > **Browse** in Power Apps Studio.

## Using the Source Code

  You can also use the [Power Apps Source Code tool](https://github.com/microsoft/PowerApps-Language-Tooling) to the code using these steps:

* Clone the repository to a local drive
* Pack the source files back into `.msapp` file:
  * [Power Apps Tooling Usage](https://github.com/microsoft/PowerApps-Language-Tooling)
* Within **Power Apps Studio**, use the `.msapp` file using **File** > **Open** > **Browse** and select the `.msapp` file you just packed.

# Random roll dice
<p>Random number generation based on timer. Progress bar with html customization. Visuals based on html components.</p>

[Sample on how to migrate List formatting "roll dice"](https://github.com/pnp/List-Formatting/tree/master/view-samples/roll-dice).

### Screen 1 - random rool dice

![home screen](./assets/rolldice.gif)  

## Applies to

* [Microsoft Power Apps](https://docs.microsoft.com/powerapps/)

## Authors

Solution|Author(s)
--------|---------
Roll Dice| [André Lage](https://github.com/aaclage) 

## Version history

Version|Date|Comments
-------|----|--------
1.0|Aug 10, 2022|Initial release


## Features

This template includes the following functions:
<ul>
<li>Home - Random number generation with associated progressbar evolution based on timer.</li>
<li>Administrative Panel: Allows you to manage player information and customization of graphics.</li>
</ul>

## Prerequisites

None

## Data Sources

Different collections with sample data.
You can use different data sources and adapt the design to your needs.

## Minimal Path to Awesome

* [Download](./solution/Roll%20Dice.msapp) the `.msapp` from the `solution` folder
* Within **Power Apps Studio**, use the `.msapp` file using **File** > **Open** > **Browse** and select the `.msapp` file you just downloaded.
* Select the **Data** tab
* ...

## Using the Source Code

  You can also use the [Power Apps Source Code tool](https://github.com/microsoft/PowerApps-Language-Tooling) to the code using these steps:

* Clone the repository to a local drive
* Pack the source files back into `.msapp` file:
  * [Power Apps Tooling Usage](https://github.com/microsoft/PowerApps-Language-Tooling)
* Within **Power Apps Studio**, use the `.msapp` file using **File** > **Open** > **Browse** and select the `.msapp` file you just packed.

## Disclaimer

**THIS CODE IS PROVIDED *AS IS* WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING ANY IMPLIED WARRANTIES OF FITNESS FOR A PARTICULAR PURPOSE, MERCHANTABILITY, OR NON-INFRINGEMENT.**

## Help

We do not support samples, but we this community is always willing to help, and we want to improve these samples. We use GitHub to track issues, which makes it easy for  community members to volunteer their time and help resolve issues.

If you encounter any issues while using this sample, you can [create a new issue](https://github.com/pnp/powerapps-samples/issues/new?assignees=&labels=Needs%3A+Triage+%3Amag%3A%2Ctype%3Abug-suspected&template=bug-report.yml&sample=random-rolldice&authors=@aaclage&title=random-rolldice).

For questions regarding this sample, [create a new question](https://github.com/pnp/powerapps-samples/issues/new?assignees=&labels=Needs%3A+Triage+%3Amag%3A%2Ctype%3Abug-suspected&template=question.yml&sample=random-rolldice&authors=@aaclage&title=random-rolldice).

Finally, if you have an idea for improvement, [make a suggestion](https://github.com/pnp/powerapps-samples/issues/new?assignees=&labels=Needs%3A+Triage+%3Amag%3A%2Ctype%3Abug-suspected&template=suggestion.yml&sample=random-rolldice&authors=@aaclage&title=random-rolldice).

## For more information

- [Overview of creating apps in Power Apps](https://docs.microsoft.com/powerapps/maker/)
- [Power Apps canvas apps documentation](https://docs.microsoft.com/en-us/powerapps/maker/canvas-apps/)


<img src="https://telemetry.sharepointpnp.com/powerapps-samples/samples/ra


