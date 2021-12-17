---------------
--  Plugins  --
---------------
return require('packer').startup({
    function()

    end,
    config={
        git={
            default_url_format='https://hub.fastgit.org/%s'
        }
    }
})
