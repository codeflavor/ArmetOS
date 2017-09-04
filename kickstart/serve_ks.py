import os

from bottle import route, run, template, static_file

@route('/<filename>')
def images(filename):
    '''This endpoint serves anaconda kickstart files
    '''
    assets_dir = get_assets_path()
    return static_file(filename, root=assets_dir)

def get_assets_path():
    project_dir = os.path.dirname(os.path.realpath(__file__))
    return '{}/{}'.format(project_dir, 'ks')

if __name__ == '__main__':
    run(host='0.0.0.0', port=8080, debug=True)
