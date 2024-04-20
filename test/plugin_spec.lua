local set_lines = function(lines)
    vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
end

describe('Hurl.nvim plugin', function()
    it('should be able to load', function()
        local hurl = require('hurl')
        assert.truthy(hurl)

        assert.are.same('split', _HURL_GLOBAL_CONFIG.mode)
        assert.are.same(false, _HURL_GLOBAL_CONFIG.debug)
    end)

    it('should be able parse the configuration file', function()
        require('hurl').setup({
            debug = true,
            mode = 'popup',
        })

        assert.are.same('popup', _HURL_GLOBAL_CONFIG.mode)
        assert.are.same(true, _HURL_GLOBAL_CONFIG.debug)
    end)

    it('should do a thing', function()
        require('hurl').setup({
            debug = true,
            mode = 'split',
        })

        set_lines({"GET http://ifconfig.io/ip", "Content-type: text/plain"})
        --vim.cmd("w out.txt")
        vim.cmd('HurlRunner')
        result = vim.api.nvim_buf_get_lines(3, 0, -1, false)
        result = vim.cmd("buffers")
        print(result[1] .. "\n")

    end)
end)
