{
  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        extraDefCfg = "process-unmapped-keys yes";
        config = # lisp
          ''
            ;; Caps to escape/control configuration for Kanata

            (defsrc
              caps
            )

            (defalias
              escctrl (tap-hold 200 200 esc lctl)
            )

            (deflayer base
              @escctrl
            )
          '';
      };
    };
  };
}
