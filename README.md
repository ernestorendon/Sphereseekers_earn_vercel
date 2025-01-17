# Sphereseekers: Marble Maze Game

## **Project Description**
Sphereseekers is a 3D maze navigation game where players control a ball through challenging mazes filled with obstacles, reset zones, and timers. The game is designed to leverage iPhone’s gyroscope and accelerometer sensors, allowing players to tilt their device to navigate the ball. The ultimate goal is to navigate the maze and reach the exit as quickly as possible, while avoiding pitfalls and reset zones.

The project is currently being developed using the Godot Engine (Mono version) with C#. Initial development and testing are being conducted on Windows and Apple platforms, with plans to migrate to macOS for iPhone development.

---

## **Gameplay Features**
1. **Maze Navigation**:
   - Navigate the ball through complex mazes.
   - Avoid reset zones marked with visible warnings (e.g., a skull icon).
   - Reach the exit to complete the level.

2. **Stopwatch Timer**:
   - A stopwatch tracks the time taken to complete the level.
   - The best time is displayed and updated if beaten.

3. **Level Progression**:
   - On completing a level, the next level loads automatically.
   - Levels increase in difficulty, introducing more obstacles and challenges.

4. **Gyroscope and Accelerometer Controls** (for iPhone):
   - Use device tilting to control the ball’s movement.
   - Real-time physics simulation for immersive gameplay.

---

## **Development Details**
### **Technology Stack**
- **Game Engine**: Godot (Mono version for C# scripting).
- **Language**: C#.
- **Version Control**: GitHub repository at [https://github.com/ScottWillard/Sphereseekers](https://github.com/ScottWillard/Sphereseekers).
- **Development Platforms**:
  - **Primary**: Windows (initial development and testing).
  - **Secondary**: macOS (for iPhone deployment).
- **Tools**:
  - Xcode (for building and testing on iPhone).
  - Git for version control.

---

## **Development Workflow**

### **1. Setting Up the Project**
1. Clone the GitHub repository:
   ```bash
   git clone https://github.com/ScottWillard/Sphereseekers.git
   ```
2. Open the project in Godot by importing the `project.godot` file.

### **2. Building the Game**
- **Level Design**:
  - Build levels using Godot’s 3D editor.
  - Add walls, obstacles, reset zones, and the exit area.
- **Collision and Physics**:
  - Ensure all game objects (e.g., walls, reset zones) have proper collision shapes.
  - Use `RigidBody3D` for the ball to enable realistic physics.

### **3. iPhone-Specific Development**
#### **Gyroscope and Accelerometer Controls**
- Use Godot’s Input API to read accelerometer and gyroscope data:
  ```csharp
  Vector3 tilt = Input.GetGyroscope();
  ```
- Map tilt data to ball movement for intuitive controls.

#### **Testing on iPhone**
1. Export the game for iPhone using Godot’s iOS export preset.
2. Transfer the exported project to Xcode.
3. Use Xcode to build and deploy the game to an iPhone for testing.

---

## **Distributing the Game for iPhone**

### **1. Requirements**
- macOS with Xcode installed.
- Apple Developer Program membership.

### **2. Steps for Distribution**
1. **Prepare the Game for Export**:
   - Add an App Store Team ID in Godot’s iOS export settings.
   - Set up provisioning profiles and certificates in Xcode.

2. **Build and Test**:
   - Use Xcode to build the game for iPhone.
   - Test the game on a physical iPhone device to ensure all features work as expected.

3. **Submit to the App Store**:
   - Archive the build in Xcode.
   - Submit the archive to the App Store for review.

---

## **Repository Structure**
```
Sphereseekers/
├── Scenes/
│   ├── Level1.tscn
│   ├── Level2.tscn
│   └── ExitArea.tscn
├── Scripts/
│   ├── BallController.cs
│   ├── UI.cs
│   ├── ExitArea.cs
│   └── CameraRig.cs
├── Assets/
│   ├── Textures/
│   └── Models/
├── project.godot
└── README.md
```

---

## **Current Progress**
1. **Level 1**:
   - Fully designed and functional with a working exit and reset zones.
   - Stopwatch and best time tracking implemented.

2. **Level Progression**:
   - Transitions to Level 2 upon completion of Level 1.

3. **GitHub Repository**:
   - All game files are tracked in the repository.
   - Large files (e.g., executables) are excluded using `.gitignore`.

---

## **Future Plans**
1. Add more levels with increasing complexity.
2. Enhance visuals and UI for a polished look.
3. Implement leaderboards and scoring systems.
4. Prepare the game for App Store submission.
5. Expand to include additional platforms (e.g., Android).

---

## **Contributing**
Team members can contribute by:
1. Cloning the repository:
   ```bash
   git clone https://github.com/ScottWillard/Sphereseekers.git
   ```
2. Creating feature branches:
   ```bash
   git checkout -b feature-branch-name
   ```
3. Committing changes:
   ```bash
   git add .
   git commit -m "Describe the changes"
   ```
4. Pushing to the repository:
   ```bash
   git push origin feature-branch-name
   ```
5. Submitting pull requests for review.

---

## **Contact**
For questions or suggestions, please contact:
- **Project Lead**: Scott Willard
- **Repository**: [GitHub Link](https://github.com/ScottWillard/Sphereseekers)

