BeRealVIP for QBcore using oxmysql

BeRealVIP is a custom vehicle access system built for FiveM QBCore servers using oxmysql. It allows server owners to manage vehicle permissions for players, giving them access to specific sections of vehicles based on granted permissions. This system includes a clean and intuitive user interface where players can select and spawn vehicles based on their assigned permissions.

Designed by: Bleezy Mack of Be Real Designs

Features:
1.Vehicle Sections: Organize vehicles into sections, allowing for better categorization and management.
2.Permissions System: Grant or revoke player access to vehicle sections using simple commands.
3.Vehicle Persistence: Once a vehicle is spawned, players can store it in garages and retain access until permissions are revoked.
4.Owner-Only Permissions: Only server owners can manage player permissions for vehicle sections.
5.User-Friendly UI: Intuitive NUI (Native User Interface) where players can browse available vehicles and spawn them with a single click.

Prerequisites:
Before installing and using BeRealVIP, ensure that you have the following dependencies installed and configured:
1. QBCore Framework
2. oxmysql
3. FiveM Server (latest build)
Make sure you have a working QBCore environment before proceeding with the installation.

Installation-

Step 1: Download the Repository
Download or clone this resource into your FiveM resources folder.

Step 2: Add BeRealVIP to server.cfg
Open your server.cfg and add the following line:
start [berealvip]

Step 3: Set Up Database
Import the SQL schema into your oxmysql database:

Step 4: Configure UI and Permissions
After installing the resource, server owners can use the following commands in-game to manage permissions:

Grant Permission:
/grantPermission [PlayerID] [SectionID]
--Grants the specified player access to a specific vehicle section.

Revoke Permission:
/revokePermission [PlayerID] [SectionID]
--Revokes the player's access to the specified vehicle section.


Usage:

Opening the Vehicle UI - Players can open the BeRealVIP vehicle access UI using the following command in-game:
/openVehicleUI

Selecting and Spawning Vehicles - Players with permission to specific sections will see a list of vehicles they can spawn. Once a vehicle is spawned, they can store it in any garage for later use.

Managing Permissions - Server owners can assign or remove permissions from players, giving them access to specific vehicle sections.

Commands:
In-Game Commands
Grant Permission: /grantPermission [PlayerID] [SectionID]
Revoke Permission: /revokePermission [PlayerID] [SectionID]
Open Vehicle UI: /openVehicleUI

SQL Queries:
Add Vehicle Section - Use SQL to insert vehicle sections and vehicles into the vehicle_sections table.

Acknowledgments
Designed by: Bleezy Mack of Be Real Designs.

Special Thanks to the QBCore and oxmysql communities for providing frameworks and support that made this project possible.
