<h5>

Looking for the ServerNet Client for Figura Avatars? Check out the [`client`](../client/) folder instead.  
Looking for the ServerNet Server for Minecraft Servers? Check out the [`server`](../server/) folder instead.
</h5>

# GSServerNet Modules
This directory contains pre-made modules for ServerNet.  
Modules are made by the creator of ServerNet or by members of the community that use ServerNet.

Modules may be stored here in this directory or in another repository.


## Installation
To start downloading modules in this directory, download this repository, open the `.zip` file it gives you, open the
`modules` folder, and open the folder for the module you wish to install.  
If you wish to download a module in another repository, click the Module Name in the Other Repositories table to go to
the repository.

Modules are usually split into a `client` and `server` directory.

The `.lua` file in the "client" directory should be put in the Figura avatar along with `GSServerNet.lua`.

The folder or `.zip` file in the "server" directory should be put in the `<world_folder>/datapacks` folder.  
Make sure to enable the datapack with the `/datapack enable` command in-game.


## Module Details
[/1]: ./gs_svnpehkui

[>1]: https://github.com/Sindercube/The-Theatre/tree/main/clothier

[@1]: https://github.com/GrandpaScout
[@2]: https://github.com/Sindercube

<!-- A reminder that "Received Messages" are messages that the *client* receives from the server. -->
<!-- "Sent Messages" are messages that the *client* sends to the server. -->

### Modules in This Directory

| Module          | Author             | Description                                                 | Received Messages | Sent Messages |
|:----------------|:-------------------|:------------------------------------------------------------|:--------------|:------------------|
| [SVNPehkui][/1] | [GrandpaScout][@1] | Allows Figura avatars to request a custom size with Pehkui. | &mdash; | `peh_reset` `peh_all` `peh_all_w` `peh_all_h` `peh_mdl` `peh_mdl_w` `peh_mdl_h` `peh_phys` `peh_phys_w` `peh_phys_h` `peh_bbox` `peh_bbox_w` `peh_bbox_h` `peh_eye_h` `peh_motion` `peh_reach` `peh_proj` `peh_drops` |

### Modules in Other Repositories

| Module | Author | Description | Received Messages | Sent Messages |
|:-------|:-------|:------------|:--------------|:------------------|
| [Clothier (Manic & Sanguine API)][>1] | [Sindercube][@2] | Allows Figura avatars to access the data from Manic and Sanguine, like the world's Blood Moon status or the player's Sanity value. | `clth_blood_moon` `clth_sanity` `clth_init` | &mdash; |
