// Zen Browser · géré dans ~/dotfiles/config/zen/user.js (lien dans le profil Zen)
// Relu à chaque démarrage de Zen : ces valeurs priment sur celles réglées dans l'interface.

// Thème Catppuccin Mocha (chrome/userChrome.css et chrome/userContent.css)
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Mode sombre (nécessaire au thème Mocha)
user_pref("browser.theme.toolbar-theme", 0);
user_pref("browser.theme.content-theme", 0);

// Mots de passe gérés par Apple Mots de passe (extension iCloud Passwords) :
// le gestionnaire intégré de Zen est coupé pour éviter les doubles propositions.
user_pref("signon.rememberSignons", false);
user_pref("signon.autofillForms", false);
user_pref("signon.generation.enabled", false);
user_pref("signon.management.page.breach-alerts.enabled", false);

// Pas d'avertissement à l'ouverture de about:config
user_pref("browser.aboutConfig.showWarning", false);
