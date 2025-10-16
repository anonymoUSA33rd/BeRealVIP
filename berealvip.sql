CREATE TABLE IF NOT EXISTS vehicle_sections (
    section_id INT AUTO_INCREMENT PRIMARY KEY,
    section_label VARCHAR(255) NOT NULL,
    vehicle_models TEXT -- store as JSON array like '["adder", "sultan", "comet2"]'
);

CREATE TABLE IF NOT EXISTS player_permissions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_identifier VARCHAR(100) NOT NULL,
    section_id INT NOT NULL,
    FOREIGN KEY (section_id) REFERENCES vehicle_sections(section_id) ON DELETE CASCADE
);
