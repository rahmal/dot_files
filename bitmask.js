// Defining Flags
const SETTING_NEWSLETTER = 1 << 0; // 1 (binary 0001)
const SETTING_COMMENTS = 1 << 1;   // 2 (binary 0010)
const SETTING_FOLLOWER = 1 << 2;   // 4 (binary 0100)
const SETTING_DARK_MODE = 1 << 3;  // 8 (binary 1000)

// Storing Settings:
let userSettings = 0; // Start with all settings off

// Turn on newsletter and comments
userSettings |= SETTING_NEWSLETTER;
userSettings |= SETTING_COMMENTS;

// userSettings is now 3 (binary 0011)

// Checking Settings:
// Check if newsletter is enabled
const hasNewsletter = (userSettings & SETTING_NEWSLETTER) !== 0; // true

// Check if dark mode is enabled
const hasDarkMode = (userSettings & SETTING_DARK_MODE) !== 0;   // false

// Modifying Settings:
userSettings |= SETTING_DARK_MODE; // Turn on dark mode

userSettings &= ~SETTING_COMMENTS; // Turn off comments

userSettings ^= SETTING_FOLLOWER; // Toggle follower setting

// Example:
const PERMISSION_READ = 1 << 0;
const PERMISSION_WRITE = 1 << 1;
const PERMISSION_EXECUTE = 1 << 2;

let userPermissions = 0;

// Grant read and write permissions
userPermissions |= PERMISSION_READ;
userPermissions |= PERMISSION_WRITE;

console.log(`User permissions: ${userPermissions}`); // Output: User permissions: 3

// Check if user has write permission
if ((userPermissions & PERMISSION_WRITE) !== 0) {
    console.log("User has write permission.");
}

// Revoke write permission
userPermissions &= ~PERMISSION_WRITE;

console.log(`User permissions after revoking write: ${userPermissions}`); // Output: User permissions after revoking write: 1


