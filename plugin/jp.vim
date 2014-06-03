function! AlignVars() range
python << END_PYTHON
import vim, re

# vim.current.range doesn't seem to work properly - use the <> marks instead
# This doesn't work if no mark has been set - could get current line instead?
start = vim.current.buffer.mark('<')[0] - 1
end = vim.current.buffer.mark('>')[0] - 1

m = re.compile("^\s*?([^\*\s]+)\s*(\**)\s*?(.*)")
decls = []
type_len = 0
ptr_len = 0

# Iterate the declarations to find the correct padding
for lineno in range(start, end + 1):
    line = vim.current.buffer[lineno]
    m = re.match("^\s*?([^\*\s]+)\s*(\**)\s*?(\S.*)", line)
    if m:
        var_type, ptrs, var_name = m.groups()
        
        if len(var_type) > type_len:
            type_len = len(var_type)
        if len(ptrs) > ptr_len:
            ptr_len = len(ptrs)
        
        decls.append((lineno, var_type, ptrs, var_name))

# Output the lines with the correct spacing
for decl in decls:
    lineno, var_type, ptrs, var_name = decl
    vim.current.buffer[lineno] = "    %s %s%s" % (var_type, ptrs.rjust(type_len - len(var_type) + ptr_len), var_name)
END_PYTHON
endfunction
