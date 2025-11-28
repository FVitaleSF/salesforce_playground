public with sharing class EmailUtils {
    // Practical email regex: allows common emails, avoids catastrophic backtracking.
    // Notes:
    // - Local part: letters, digits, underscore, plus, hyphen, dot (no leading/trailing dot, no consecutive dots)
    // - Domain: labels separated by dots, each 1-63 chars, alphanum plus hyphen (no leading/trailing hyphen)
    // - TLD: at least 2 letters
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
        '^' +
        '(?=.{1,254}$)' + // overall length guard
        // local part
        '(?=.{1,64}@)' + // local part length guard
        '(?:[A-Za-z0-9_+%-]+(?:\\.[A-Za-z0-9_+%-]+)*)' +
        '@' +
        // domain
        '(?:[A-Za-z0-9](?:[A-Za-z0-9-]{0,61}[A-Za-z0-9])?)(?:\\.(?:[A-Za-z0-9](?:[A-Za-z0-9-]{0,61}[A-Za-z0-9])?))*' +
        // TLD
        '(?:\\.[A-Za-z]{2,})' +
        '$'
    );

    /**
     * Validate email format. Null or blank is treated as invalid.
     * @param email The email string to validate.
     * @return true if email has a valid format; false otherwise.
     */
    public static Boolean isValid(String email) {
        return isValid(email, false);
    }

    /**
     * Validate email format with option to allow blank values.
     * @param email The email string to validate.
     * @param allowBlank If true, null/blank (after trim) returns true.
     * @return true if valid format (or blank allowed and blank provided); false otherwise.
     */
    public static Boolean isValid(String email, Boolean allowBlank) {
        if (email == null) {
            return allowBlank;
        }
        String trimmed = email.trim();
        if (trimmed.isEmpty()) {
            return allowBlank;
        }
        // Salesforce Email fields are case-insensitive; normalize for regex if desired
        // but regex here is case-insensitive via ranges.
        return EMAIL_PATTERN.matcher(trimmed).matches();
    }
}
