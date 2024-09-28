-- Table to store vehicle sections and related vehicle models
CREATE TABLE IF NOT EXISTS vehicle_sections (
  section_id INT AUTO_INCREMENT PRIMARY KEY,
  section_label VARCHAR(255),
  vehicle_model VARCHAR(255)
);

-- Table to store player permissions
CREATE TABLE IF NOT EXISTS player_permissions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  player_identifier VARCHAR(50),
  section_id INT,
  FOREIGN KEY (section_id) REFERENCES vehicle_sections(section_id)
);
