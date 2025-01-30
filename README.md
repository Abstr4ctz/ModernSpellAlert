# Requires [SuperWoW](https://github.com/balakethelock/SuperWoW)!

### ✨ Real-Time Spell Alerts for Vanilla WoW (1.12) and Turtle WoW
A powerful, lightweight, and highly customizable addon for tracking spell casts and procs in real time.

![Example Polymorph Alert](https://github.com/user-attachments/assets/8278280c-2b69-400a-8b54-59b65df76877)

## ✨ Features
- ✔️ Track any spell (e.g., Fireball) or proc (e.g., Shadow Trance).
- ✔️ Track who casted AoE spells, totems, traps that affect you.
- ✔️ Track items ussage (Trinkets, Potions, Items, etc.).
- ✔️ Alerts about incoming spells at **cast start** for quick reactions.
- ✔️ Add your own spells and procs easily.
- ✔️ Quickly target the CASTER and the TARGET of lastly triggered alert.
- ✔️ Play sound effects for all spells.
- ✔️ Fully customizable tracking options and visuals.

---

## ✨ Tracking Options
![Hunter](https://github.com/user-attachments/assets/04cbfa39-4d5a-43ab-887c-3ee68056fd88)
| **Option**           | **Description**                               |
|-----------------------|-----------------------------------------------|
| **Track on Player**   | Tracks spells targeting the Player.          |
| **Track by Player**   | Tracks spells cast by the Player, including self-procs. |
| **Track on Target**   | Tracks spells targeting your current Target. |
| **Track by Target**   | Tracks spells cast by your current Target.   |
| **Track on Friendly** | Tracks spells targeting friendly units (including the Player). |
| **Track by Friendly** | Tracks spells cast by friendly units other than the Player. |
| **Track on Hostile**  | Tracks spells targeting hostile units.        |
| **Track by Hostile**  | Tracks spells cast by hostile units.          |

### 💡 Note
For spells that are considered AoE and don't have a target, **Track on Player** will trigger alert on spell's contact with player.\
If spells are targetted, it will alert at start of cast. To trigger alert for AoE spells when cast is being started, pick **Track by Target** or **Track on Hostile**.


---

## ✨ Quick Targeting
![WoW 2025-01-22 21-29-55-275](https://github.com/user-attachments/assets/2bef6d11-f9b5-4402-98b0-61dbafd3af3b)

To quickly target last Caster or Target, simply keybind the options shown on the image.<br/><br/>
Or you can use macros:
```
/msacaster
/msatarget
```
For example:
```
/msacaster
/CastSpellByName Counterspell
```

---

## ✨ Add Your Own Spells and Procs
![Before Adding Spells](https://github.com/user-attachments/assets/7428d645-3dc5-4b01-9cd5-8a9cfdd3e7d5)  
![After Adding Spells](https://github.com/user-attachments/assets/54fed797-91dd-4f3b-bff8-f63e9318dba8)

To add a custom spell or proc:
1. Open `ModernSpellAlertSettings.lua` in [Notepad++](https://notepad-plus-plus.org/).
2. Find your class and add the spell name in quotation marks, followed by a comma.

---

### 🚧 Beta Version Disclaimer
This addon is currently in beta. Some features are still under development.

---

## 🔧 To-Do List
- ⚙️ Add spell priority levels for alerts.  
- ⚙️ Add sounds to enhance alerts.  

---

Feel free to contribute or provide feedback!
