" Vim completion script
" Language:             Ruby
" Maintainer:           Mark Guzman <segfault@hasno.info>
" URL:                  https://github.com/vim-ruby/vim-ruby
" Anon CVS:             See above site
" Release Coordinator:  Doug Kearns <dougkearns@gmail.com>
" Maintainer Version:   0.8.1
" ----------------------------------------------------------------------------
"
" Ruby IRB/Complete author: Keiju ISHITSUKA(keiju@ishitsuka.com)
" ----------------------------------------------------------------------------

" {{{ requirement checks
if !has('ruby')
    echo "NO RUBY HERE EITHER!"
    s:ErrMsg( "Error: Rubycomplete requires vim compiled with +ruby" )
    s:ErrMsg( "Error: falling back to syntax completion" )
    " lets fall back to syntax completion
    setlocal omnifunc=syntaxcomplete#Complete
    finish
endif

if version < 700
    s:ErrMsg( "Error: Required vim >= 7.0" )
    finish
endif
" }}} requirement checks

" {{{ configuration failsafe initialization
if !exists("g:rubycomplete_rails")
    let g:rubycomplete_rails = 0
endif

if !exists("g:rubycomplete_classes_in_global")
    let g:rubycomplete_classes_in_global = 0
endif

if !exists("g:rubycomplete_buffer_loading")
    let g:rubycomplete_buffer_loading = 0
endif

if !exists("g:rubycomplete_include_object")
    let g:rubycomplete_include_object = 0
endif

if !exists("g:rubycomplete_include_objectspace")
    let g:rubycomplete_include_objectspace = 0
endif
" }}} configuration failsafe initialization

" {{{ vim-side support functions
let s:rubycomplete_debug = 0

function! s:ErrMsg(msg)
    echohl ErrorMsg
    echo a:msg
    echohl None
endfunction

function! s:dprint(msg)
    if s:rubycomplete_debug == 1
        echom a:msg
    endif
endfunction

function! s:GetBufferRubyModule(name, ...)
    if a:0 == 1
        let [snum,enum] = s:GetBufferRubyEntity(a:name, "module", a:1)
    else
        let [snum,enum] = s:GetBufferRubyEntity(a:name, "module")
    endif
    return snum . '..' . enum
endfunction

function! s:GetBufferRubyClass(name, ...)
    if a:0 >= 1
        let [snum,enum] = s:GetBufferRubyEntity(a:name, "class", a:1)
    else
        let [snum,enum] = s:GetBufferRubyEntity(a:name, "class")
    endif
    return snum . '..' . enum
endfunction

function! s:GetBufferRubySingletonMethods(name)
endfunction

function! s:GetBufferRubyEntity( name, type, ... )
    let lastpos = getpos(".")
    let lastline = lastpos
    if (a:0 >= 1)
        let lastline = [ 0, a:1, 0, 0 ]
        call cursor( a:1, 0 )
    endif

    let stopline = 1

    let crex = '^\s*\<' . a:type . '\>\s*\<' . a:name . '\>\s*\(<\s*.*\s*\)\?'
    let [lnum,lcol] = searchpos( crex, 'w' )
    "let [lnum,lcol] = searchpairpos( crex . '\zs', '', '\(end\|}\)', 'w' )

    if lnum == 0 && lcol == 0
        call cursor(lastpos[1], lastpos[2])
        return [0,0]
    endif

    let curpos = getpos(".")
    let [enum,ecol] = searchpairpos( crex, '', '\(end\|}\)', 'wr' )
    call cursor(lastpos[1], lastpos[2])

    if lnum > enum
        return [0,0]
    endif
    " we found a the class def
    return [lnum,enum]
endfunction

function! s:IsInClassDef()
    return s:IsPosInClassDef( line('.') )
endfunction

function! s:IsPosInClassDef(pos)
    let [snum,enum] = s:GetBufferRubyEntity( '.*', "class" )
    let ret = 'nil'

    if snum < a:pos && a:pos < enum
        let ret = snum . '..' . enum
    endif

    return ret
endfunction

function! s:GetRubyVarType(v)
    let stopline = 1
    let vtp = ''
    let pos = getpos('.')
    let sstr = '^\s*#\s*@var\s*'.a:v.'\>\s\+[^ \t]\+\s*$'
    let [lnum,lcol] = searchpos(sstr,'nb',stopline)
    if lnum != 0 && lcol != 0
        call setpos('.',pos)
        let str = getline(lnum)
        let vtp = substitute(str,sstr,'\1','')
        return vtp
    endif
    call setpos('.',pos)
    let ctors = '\(now\|new\|open\|get_instance'
    if exists('g:rubycomplete_rails') && g:rubycomplete_rails == 1 && s:rubycomplete_rails_loaded == 1
        let ctors = ctors.'\|find\|create'
    else
    endif
    let ctors = ctors.'\)'

    let fstr = '=\s*\([^ \t]\+.' . ctors .'\>\|[\[{"''/]\|%[xwQqr][(\[{@]\|[A-Za-z0-9@:\-()\.]\+...\?\|lambda\|&\)'
    let sstr = ''.a:v.'\>\s*[+\-*/]*'.fstr
    let [lnum,lcol] = searchpos(sstr,'nb',stopline)
    if lnum != 0 && lcol != 0
        let str = matchstr(getline(lnum),fstr,lcol)
        let str = substitute(str,'^=\s*','','')

        call setpos('.',pos)
        if str == '"' || str == '''' || stridx(tolower(str), '%q[') != -1
            return 'String'
        elseif str == '[' || stridx(str, '%w[') != -1
            return 'Array'
        elseif str == '{'
            return 'Hash'
        elseif str == '/' || str == '%r{'
            return 'Regexp'
        elseif strlen(str) >= 4 && stridx(str,'..') != -1
            return 'Range'
        elseif stridx(str, 'lambda') != -1 || str == '&'
            return 'Proc'
        elseif strlen(str) > 4
            let l = stridx(str,'.')
            return str[0:l-1]
        end
        return ''
    endif
    call setpos('.',pos)
    return ''
endfunction

"}}} vim-side support functions

"{{{ vim-side completion function
function! rubycomplete#Init()
    execute "ruby VimRubyCompletion.preload_rails"
endfunction

function! rubycomplete#Complete(findstart, base)
     "findstart = 1 when we need to get the text length
    if a:findstart
        let line = getline('.')
        let idx = col('.')
        while idx > 0
            let idx -= 1
            let c = line[idx-1]
            if c =~ '\w'
                continue
            elseif ! c =~ '\.'
                idx = -1
                break
            else
                break
            endif
        endwhile

        return idx
    "findstart = 0 when we need to return the list of completions
    else
        let g:rubycomplete_completions = []
        execute "ruby VimRubyCompletion.get_completions('" . a:base . "')"
        return g:rubycomplete_completions
    endif
endfunction
"}}} vim-side completion function

"{{{ ruby-side code
function! s:DefRuby()
ruby << RUBYEOF
# {{{ ruby completion

begin
    require 'rubygems' # let's assume this is safe...?
rescue Exception
    #ignore?
end
class VimRubyCompletion
# {{{ constants
  @@debug = false
  @@ReservedWords = [
        "BEGIN", "END",
        "alias", "and",
        "begin", "break",
        "case", "class",
        "def", "defined", "do",
        "else", "elsif", "end", "ensure",
        "false", "for",
        "if", "in",
        "module",
        "next", "nil", "not",
        "or",
        "redo", "rescue", "retry", "return",
        "self", "super",
        "then", "true",
        "undef", "unless", "until",
        "when", "while",
        "yield",
      ]

  @@Operators = [ "%", "&", "*", "**", "+",  "-",  "/",
        "<", "<<", "<=", "<=>", "==", "===", "=~", ">", ">=", ">>",
        "[]", "[]=", "^", ]
# }}} constants

# {{{ buffer analysis magic
  def load_requires
    buf = VIM::Buffer.current
    enum = buf.line_number
    nums = Range.new( 1, enum )
    nums.each do |x|
      ln = buf[x]
      begin
        eval( "require %s" % $1 ) if /.*require\s*(.*)$/.match( ln )
      rescue Exception
        #ignore?
      end
    end
  end

  def load_buffer_class(name)
    dprint "load_buffer_class(%s) START" % name
    classdef = get_buffer_entity(name, 's:GetBufferRubyClass("%s")')
    return if classdef == nil

    pare = /^\s*class\s*(.*)\s*<\s*(.*)\s*\n/.match( classdef )
    load_buffer_class( $2 ) if pare != nil  && $2 != name # load parent class if needed

    mixre = /.*\n\s*include\s*(.*)\s*\n/.match( classdef )
    load_buffer_module( $2 ) if mixre != nil && $2 != name # load mixins if needed

    begin
      eval classdef
    rescue Exception
      VIM::evaluate( "s:ErrMsg( 'Problem loading class \"%s\", was it already completed?' )" % name )
    end
    dprint "load_buffer_class(%s) END" % name
  end

  def load_buffer_module(name)
    dprint "load_buffer_module(%s) START" % name
    classdef = get_buffer_entity(name, 's:GetBufferRubyModule("%s")')
    return if classdef == nil

    begin
      eval classdef
    rescue Exception
      VIM::evaluate( "s:ErrMsg( 'Problem loading module \"%s\", was it already completed?' )" % name )
    end
    dprint "load_buffer_module(%s) END" % name
  end

  def get_buffer_entity(name, vimfun)
    loading_allowed = VIM::evaluate("exists('g:rubycomplete_buffer_loading') && g:rubycomplete_buffer_loading")
    return nil if loading_allowed.to_i.zero?
    return nil if /(\"|\')+/.match( name )
    buf = VIM::Buffer.current
    nums = eval( VIM::evaluate( vimfun % name ) )
    return nil if nums == nil
    return nil if nums.min == nums.max && nums.min == 0

    dprint "get_buffer_entity START"
    visited = []
    clscnt = 0
    bufname = VIM::Buffer.current.name
    classdef = ""
    cur_line = VIM::Buffer.current.line_number
    while (nums != nil && !(nums.min == 0 && nums.max == 0) )
      dprint "visited: %s" % visited.to_s
      break if visited.index( nums )
      visited << nums

      nums.each do |x|
        if x != cur_line
          next if x == 0
          ln = buf[x]
          if /^\s*(module|class|def|include)\s+/.match(ln)
            clscnt += 1 if $1 == "class"
            #dprint "\$1$1
            classdef += "%s\n" % ln
            classdef += "end\n" if /def\s+/.match(ln)
            dprint ln
          end
        end
      end

      nm = "%s(::.*)*\", %s, \"" % [ name, nums.last ]
      nums = eval( VIM::evaluate( vimfun % nm ) )
      dprint "nm: \"%s\"" % nm
      dprint "vimfun: %s" % (vimfun % nm)
      dprint "got nums: %s" % nums.to_s
    end
    if classdef.length > 1
        classdef += "end\n"*clscnt
        # classdef = "class %s\n%s\nend\n" % [ bufname.gsub( /\/|\\/, "_" ), classdef ]
    end

    dprint "get_buffer_entity END"
    dprint "classdef====start"
    lns = classdef.split( "\n" )
    lns.each { |x| dprint x }
    dprint "classdef====end"
    return classdef
  end

  def get_var_type( receiver )
    if /(\"|\')+/.match( receiver )
      "String"
    else
      VIM::evaluate("s:GetRubyVarType('%s')" % receiver)
    end
  end

  def dprint( txt )
    print txt if @@debug
  end

  def get_buffer_entity_list( type )
    # this will be a little expensive.
    loading_allowed = VIM::evaluate("exists('g:rubycomplete_buffer_loading') && g:rubycomplete_buffer_loading")
    allow_aggressive_load = VIM::evaluate("exists('g:rubycomplete_classes_in_global') && g:rubycomplete_classes_in_global")
    return [] if allow_aggressive_load.to_i.zero? || loading_allowed.to_i.zero?

    buf = VIM::Buffer.current
    eob = buf.length
    ret = []
    rg = 1..eob
    re = eval( "/^\s*%s\s*([A-Za-z0-9_:-]*)(\s*<\s*([A-Za-z0-9_:-]*))?\s*/" % type )

    rg.each do |x|
      if re.match( buf[x] )
        next if type == "def" && eval( VIM::evaluate("s:IsPosInClassDef(%s)" % x) ) != nil
        ret.push $1
      end
    end

    return ret
  end

  def get_buffer_modules
    return get_buffer_entity_list( "modules" )
  end

  def get_buffer_methods
    return get_buffer_entity_list( "def" )
  end

  def get_buffer_classes
    return get_buffer_entity_list( "class" )
  end


  def load_rails
    allow_rails = VIM::evaluate("exists('g:rubycomplete_rails') && g:rubycomplete_rails")
    return if allow_rails.to_i.zero?

    buf_path = VIM::evaluate('expand("%:p")')
    file_name = VIM::evaluate('expand("%:t")')
    vim_dir = VIM::evaluate('getcwd()')
    file_dir = buf_path.gsub( file_name, '' )
    file_dir.gsub!( /\\/, "/" )
    vim_dir.gsub!( /\\/, "/" )
    vim_dir << "/"
    dirs = [ vim_dir, file_dir ]
    sdirs = [ "", "./", "../", "../../", "../../../", "../../../../" ]
    rails_base = nil

    dirs.each do |dir|
      sdirs.each do |sub|
        trail = "%s%s" % [ dir, sub ]
        tcfg = "%sconfig" % trail

        if File.exists?( tcfg )
          rails_base = trail
          break
        end
      end
      break if rails_base
    end

    return if rails_base == nil
    $:.push rails_base unless $:.index( rails_base )

    rails_config = rails_base + "config/"
    rails_lib = rails_base + "lib/"
    $:.push rails_config unless $:.index( rails_config )
    $:.push rails_lib unless $:.index( rails_lib )

    bootfile = rails_config + "boot.rb"
    envfile = rails_config + "environment.rb"
    if File.exists?( bootfile ) && File.exists?( envfile )
      begin
        require bootfile
        require envfile
        begin
          require 'console_app'
          require 'console_with_helpers'
        rescue Exception
          dprint "Rails 1.1+ Error %s" % $!
          # assume 1.0
        end
        #eval( "Rails::Initializer.run" ) #not necessary?
        VIM::command('let s:rubycomplete_rails_loaded = 1')
        dprint "rails loaded"
      rescue Exception
        dprint "Rails Error %s" % $!
        VIM::evaluate( "s:ErrMsg('Error loading rails environment')" )
      end
    end
  end

  def get_rails_helpers
    allow_rails = VIM::evaluate("exists('g:rubycomplete_rails') && g:rubycomplete_rails")
    rails_loaded = VIM::evaluate('s:rubycomplete_rails_loaded')
    return [] if allow_rails.to_i.zero? || rails_loaded.to_i.zero?

    buf_path = VIM::evaluate('expand("%:p")')
    buf_path.gsub!( /\\/, "/" )
    path_elm = buf_path.split( "/" )
    dprint "buf_path: %s" % buf_path
    types = [ "app", "db", "lib", "test", "components", "script" ]

    i = nil
    ret = []
    type = nil
    types.each do |t|
      i = path_elm.index( t )
      break if i
    end
    type = path_elm[i]
    type.downcase!

    dprint "type: %s" % type
    case type
      when "app"
        i += 1
        subtype = path_elm[i]
        subtype.downcase!

        dprint "subtype: %s" % subtype
        case subtype
          when "views"
            ret += ActionView::Base.instance_methods
            ret += ActionView::Base.methods
          when "controllers"
            ret += ActionController::Base.instance_methods
            ret += ActionController::Base.methods
          when "models"
            ret += ActiveRecord::Base.instance_methods
            ret += ActiveRecord::Base.methods
        end

      when "db"
        ret += ActiveRecord::ConnectionAdapters::SchemaStatements.instance_methods
        ret += ActiveRecord::ConnectionAdapters::SchemaStatements.methods
    end


    return ret
  end

  def add_rails_columns( cls )
    allow_rails = VIM::evaluate("exists('g:rubycomplete_rails') && g:rubycomplete_rails")
    rails_loaded = VIM::evaluate('s:rubycomplete_rails_loaded')
    return [] if allow_rails.to_i.zero? || rails_loaded.to_i.zero?

    begin
        eval( "#{cls}.establish_connection" )
        return [] unless eval( "#{cls}.ancestors.include?(ActiveRecord::Base).to_s" )
        col = eval( "#{cls}.column_names" )
        return col if col
    rescue
        dprint "add_rails_columns err: (cls: %s) %s" % [ cls, $! ]
        return []
    end
    return []
  end

  def clean_sel(sel, msg)
    sel.delete_if { |x| x == nil }
    sel.uniq!
    sel.grep(/^#{Regexp.quote(msg)}/) if msg != nil
  end

  def get_rails_view_methods
    allow_rails = VIM::evaluate("exists('g:rubycomplete_rails') && g:rubycomplete_rails")
    rails_loaded = VIM::evaluate('s:rubycomplete_rails_loaded')
    return [] if allow_rails.to_i.zero? || rails_loaded.to_i.zero?

    buf_path = VIM::evaluate('expand("%:p")')
    buf_path.gsub!( /\\/, "/" )
    pelm = buf_path.split( "/" )
    idx = pelm.index( "views" )

    return [] unless idx
    idx += 1

    clspl = pelm[idx].camelize.pluralize
    cls = clspl.singularize

    ret = []
    begin
      ret += eval( "#{cls}.instance_methods" )
      ret += eval( "#{clspl}Helper.instance_methods" )
    rescue Exception
      dprint "Error: Unable to load rails view helpers for %s: %s" % [ cls, $! ]
    end

    return ret
  end
# }}} buffer analysis magic

# {{{ main completion code
  def self.preload_rails
    a = VimRubyCompletion.new
    require 'Thread'
    Thread.new(a) do |b|
      begin
      b.load_rails
      rescue
      end
    end
    a.load_rails
  rescue
  end

  def self.get_completions(base)
    b = VimRubyCompletion.new
    b.get_completions base
  end

  def get_completions(base)
    loading_allowed = VIM::evaluate("exists('g:rubycomplete_buffer_loading') && g:rubycomplete_buffer_loading")
    if loading_allowed.to_i == 1
      load_requires
      load_rails
    end

    input = VIM::Buffer.current.line
    cpos = VIM::Window.current.cursor[1] - 1
    input = input[0..cpos]
    input += base
    input.sub!(/.*[ \t\n\"\\'`><=;|&{(]/, '') # Readline.basic_word_break_characters
    input.sub!(/self\./, '')
    input.sub!(/.*((\.\.[\[(]?)|([\[(]))/, '')

    dprint 'input %s' % input
    message = nil
    receiver = nil
    methods = []
    variables = []
    classes = []
    constants = []

    case input
      when /^(\/[^\/]*\/)\.([^.]*)$/ # Regexp
        receiver = $1
        message = Regexp.quote($2)
        methods = Regexp.instance_methods(true)

      when /^([^\]]*\])\.([^.]*)$/ # Array
        receiver = $1
        message = Regexp.quote($2)
        methods = Array.instance_methods(true)

      when /^([^\}]*\})\.([^.]*)$/ # Proc or Hash
        receiver = $1
        message = Regexp.quote($2)
        methods = Proc.instance_methods(true) | Hash.instance_methods(true)

      when /^(:[^:.]*)$/ # Symbol
        dprint "symbol"
        if Symbol.respond_to?(:all_symbols)
          receiver = $1
          message = $1.sub( /:/, '' )
          methods = Symbol.all_symbols.collect{|s| s.id2name}
          methods.delete_if { |c| c.match( /'/ ) }
        end

      when /^::([A-Z][^:\.\(]*)$/ # Absolute Constant or class methods
        dprint "const or cls"
        receiver = $1
        methods = Object.constants
        methods.grep(/^#{receiver}/).collect{|e| "::" + e}

      when /^(((::)?[A-Z][^:.\(]*)+?)::?([^:.]*)$/ # Constant or class methods
        receiver = $1
        message = Regexp.quote($4)
        dprint "const or cls 2 [recv: \'%s\', msg: \'%s\']" % [ receiver, message ]
        load_buffer_class( receiver )
        begin
          classes = eval("#{receiver}.constants")
          #methods = eval("#{receiver}.methods")
        rescue Exception
          dprint "exception: %s" % $!
          methods = []
        end
        methods.grep(/^#{message}/).collect{|e| receiver + "::" + e}

      when /^(:[^:.]+)\.([^.]*)$/ # Symbol
        dprint "symbol"
        receiver = $1
        message = Regexp.quote($2)
        methods = Symbol.instance_methods(true)

      when /^([0-9_]+(\.[0-9_]+)?(e[0-9]+)?)\.([^.]*)$/ # Numeric
        dprint "numeric"
        receiver = $1
        message = Regexp.quote($4)
        begin
          methods = eval(receiver).methods
        rescue Exception
          methods = []
        end

      when /^(\$[^.]*)$/ #global
        dprint "global"
        methods = global_variables.grep(Regexp.new(Regexp.quote($1)))

      when /^((\.?[^.]+)+?)\.([^.]*)$/ # variable
        dprint "variable"
        receiver = $1
        message = Regexp.quote($3)
        load_buffer_class( receiver )

        cv = eval("self.class.constants")
        vartype = get_var_type( receiver )
        dprint "vartype: %s" % vartype
        if vartype != ''
          load_buffer_class( vartype )

          begin
            methods = eval("#{vartype}.instance_methods")
            variables = eval("#{vartype}.instance_variables")
          rescue Exception
            dprint "load_buffer_class err: %s" % $!
          end
        elsif (cv).include?(receiver)
          # foo.func and foo is local var.
          methods = eval("#{receiver}.methods")
          vartype = receiver
        elsif /^[A-Z]/ =~ receiver and /\./ !~ receiver
          vartype = receiver
          # Foo::Bar.func
          begin
            methods = eval("#{receiver}.methods")
          rescue Exception
          end
        else
          # func1.func2
          ObjectSpace.each_object(Module){|m|
            next if m.name != "IRB::Context" and
              /^(IRB|SLex|RubyLex|RubyToken)/ =~ m.name
            methods.concat m.instance_methods(false)
          }
        end
        variables += add_rails_columns( "#{vartype}" ) if vartype && vartype.length > 0

      when /^\(?\s*[A-Za-z0-9:^@.%\/+*\(\)]+\.\.\.?[A-Za-z0-9:^@.%\/+*\(\)]+\s*\)?\.([^.]*)/
        message = $1
        methods = Range.instance_methods(true)

      when /^\.([^.]*)$/ # unknown(maybe String)
        message = Regexp.quote($1)
        methods = String.instance_methods(true)

    else
      dprint "default/other"
      inclass = eval( VIM::evaluate("s:IsInClassDef()") )

      if inclass != nil
        dprint "inclass"
        classdef = "%s\n" % VIM::Buffer.current[ inclass.min ]
        found = /^\s*class\s*([A-Za-z0-9_-]*)(\s*<\s*([A-Za-z0-9_:-]*))?\s*\n$/.match( classdef )

        if found != nil
          receiver = $1
          message = input
          load_buffer_class( receiver )
          begin
            methods = eval( "#{receiver}.instance_methods" )
            variables += add_rails_columns( "#{receiver}" )
          rescue Exception
            found = nil
          end
        end
      end

      if inclass == nil || found == nil
        dprint "inclass == nil"
        methods = get_buffer_methods
        methods += get_rails_view_methods

        cls_const = Class.constants
        constants = cls_const.select { |c| /^[A-Z_-]+$/.match( c ) }
        classes = eval("self.class.constants") - constants
        classes += get_buffer_classes
        classes += get_buffer_modules

        include_objectspace = VIM::evaluate("exists('g:rubycomplete_include_objectspace') && g:rubycomplete_include_objectspace")
        ObjectSpace.each_object(Class) { |cls| classes << cls.to_s } if include_objectspace == "1"
        message = receiver = input
      end

      methods += get_rails_helpers
      methods += Kernel.public_methods
    end


    include_object = VIM::evaluate("exists('g:rubycomplete_include_object') && g:rubycomplete_include_object")
    methods = clean_sel( methods, message )
    methods = (methods-Object.instance_methods) if include_object == "0"
    rbcmeth = (VimRubyCompletion.instance_methods-Object.instance_methods) # lets remove those rubycomplete methods
    methods = (methods-rbcmeth)

    variables = clean_sel( variables, message )
    classes = clean_sel( classes, message ) - ["VimRubyCompletion"]
    constants = clean_sel( constants, message )

    valid = []
    valid += methods.collect { |m| { :name => m, :type => 'm' } }
    valid += variables.collect { |v| { :name => v, :type => 'v' } }
    valid += classes.collect { |c| { :name => c, :type => 't' } }
    valid += constants.collect { |d| { :name => d, :type => 'd' } }
    valid.sort! { |x,y| x[:name] <=> y[:name] }

    outp = ""

    rg = 0..valid.length
    rg.step(150) do |x|
      stpos = 0+x
      enpos = 150+x
      valid[stpos..enpos].each { |c| outp += "{'word':'%s','item':'%s','kind':'%s'}," % [ c[:name], c[:name], c[:type] ] }
      outp.sub!(/,$/, '')

      VIM::command("call extend(g:rubycomplete_completions, [%s])" % outp)
      outp = ""
    end
  end
# }}} main completion code

end # VimRubyCompletion
# }}} ruby completion
RUBYEOF
endfunction

let s:rubycomplete_rails_loaded = 0

call s:DefRuby()
"}}} ruby-side code


" vim:tw=78:sw=4:ts=8:et:fdm=marker:ft=vim:norl:
