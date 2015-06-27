#utility to improve development experience with ci
#7/6/2010		
#first version
#
#8/3/2010		
#application folder detect
#create dirs when no exist
#
#10/22/2010	
#opts added
#
#10/23/2010	
#rewrite
#command option added
#prevent overwriting
#						
#todo: 
#add config option
#rewrite get_app_folder
#

import sys,os
from optparse import OptionParser
	
tmpls={
'model':
'''<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class %s extends Model{

	function %s(){
		parent::Model();
	}
}''' ,
'controller':
'''<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class %s extends Controller{

	function %s(){
		parent::Controller();
	}
	
	function index(){
		$data['']='';
		$this->load->view('',$data);
	}
}
/* End of file %s.php */
/* Location: ./system/application/controllers/%s.php */''' ,
'view':
'''<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
</head>
<body>
	
</body>
</html>''',
'helper':
'''<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

function (){
	
}
''',
'jquery':
'''(function($) {
	$(document).ready(function() {
		
	});
})(jQuery);'''
}

pathes={
'model':'models/%s.php',
'controller':'controllers/%s.php',
'helper':'helpers/MY_%s_helper.php',
'view':'views/%s.php',
'jquery':'js/%s.js'
}

def get_app_folder():
	app_folder='application/'
	if not os.path.isdir(app_folder):
		app_folder='system/application/'
	if not os.path.isdir(app_folder):
		if os.path.basename(os.path.abspath(os.path.curdir))=='application':
			app_folder=''
		else:
			sys.stderr.write("application folder not found")
			raise SystemExit(1)
	return app_folder
	
app_folder=get_app_folder()

def get_path(type,name):
	return app_folder+pathes.get(type) % name
	
def get_tmpl(type,name):
	return {
		'controller': lambda name: tmpls['controller'] % (name.capitalize(),name.capitalize(),name,name),
		'model': lambda name: tmpls['model'] % (name.capitalize(),name.capitalize()),
		'view': lambda name: tmpls['view'],
		'helper': lambda name: tmpls.get('helper')
	}[type](name)
	
	
def write_to_file(path,content):
	if os.path.exists(path):
		print("%s already exists" % path)
		return False
		
	if not os.path.isdir(os.path.dirname(path)):
		os.makedirs(os.path.dirname(path))
		
	f=open(path,'w')
	f.write(content)
	f.close()
	return True

def create_tmpl(type,name):
	tmpl=get_tmpl(type,name)
	path=get_path(type,name)
	write_to_file(path,tmpl)
	
	
#path=os.path.dirname(path)+'/view_'+os.path.basename(path);
	
	
#----------------------------------------------------------------------------#
#start here
#----------------------------------------------------------------------------#
USAGE="%prog	-t <model|view|controller|helper|jquery|css> [-n <file_name>] [-c <cmd>]"
VERSION="%prog 0.1"
p = OptionParser(usage=USAGE, version=VERSION)
p.add_option("-t",dest="type", help="type of file")
p.add_option("-n",dest="file_name", default="", help="file name")
p.add_option("-c",dest="command", default="",help="command")

opts, args = p.parse_args()


path=get_path(opts.type,opts.file_name)
if not os.path.exists(path):
	create_tmpl(opts.type,opts.file_name)
if opts.command != "":
	os.system('%s "%s"' % (opts.command,path))


