// Project Tracker
// A simple console application for tracking projects.

// Create a class to represent a project
class Project {
  // Properties
  String name;
  String status;
  String technology;

  // Constructor
  Project(this.name, this.status, this.technology);
}

void main() {
  // Create 3 Project objects
  Project project1 = Project(
    "Scoutly",
    "In Progress",
    "AI",
  );

  Project project2 = Project(
    "Smart Assistant",
    "Completed",
    "Python",
  );

  Project project3 = Project(
    "Movie Recommender",
    "Planned",
    "Machine Learning",
  );

  // Store the projects in a List
  List<Project> projects = [
    project1,
    project2,
    project3,
  ];

  // Display the projects using a loop
  print("========== My Projects ==========");
  print("");

  for (var project in projects) {
    print("Project: ${project.name}");
    print("Status: ${project.status}");
    print("Technology: ${project.technology}");
    print("--------------------------------");
  }
}