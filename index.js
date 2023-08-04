const fs = require("fs");
const path = require("path");
const { exec } = require("child_process");

module.exports = function AHK_Controller(mod) {
  mod.game.initialize("me");

  mod.game.me.on("enter_combat", () => {
    stateAHK("1");
  });

  mod.game.me.on("leave_combat", () => {
    stateAHK("0");
  });

  function stateAHK(state) {
    fs.writeFile(path.join("./state.txt"), state, (err) => {
      if (err) throw err;
      console.log(
        "AHK has been " + state == 1 ? "activated." : "desactivated."
      );
    });
  }

  function launchAutoHotKeyScript() {
    // Remplacez "chemin/vers/script.ahk" par le chemin absolu vers votre script.ahk
    const scriptPath = "./script.ahk";

    // Utilisez "start" pour exécuter le script.ahk avec AutoHotKey (s'il est associé à AHK)
    exec(`start ${scriptPath}`, (error) => {
      if (error) {
        console.error("Erreur lors du lancement du script AutoHotKey :", error);
      } else {
        console.log("Script AutoHotKey lancé avec succès.");
      }
    });
  }

  mod.hook("S_EXIT", 3, (event) => {
    if (event.category == 0 && event.code == 0) {
      stateAHK("3");
      console.log("AHK has been shutdown");
    }
  });

  launchAutoHotKeyScript();
};
