#!/usr/bin/env python

def use_python_gen():
    print('generating "/etc/portage/package.use/gen-python"')
    options  = {}
    packages = {}
    for line in open('/etc/portage/d.gen/package.use/python', 'r'):
        line = line.strip()
        if len(line) == 0 or line[0] == '#': continue
        if line[0] == '!':
            key, value = line[1:].split('=', 1)
            options[key.strip()] = value.strip()
        else:
            pkg, args = line.split(' ', 1)
            flags = packages.get(pkg, 0)
            for arg in args.split(' '):
                if   arg == '2':      flags |= 1
                elif arg == '3':      flags |= 2
                elif arg == 'single': flags |= 4
            packages[pkg] = flags
    output = {
        1 : "python_targets_" + options['python2'],
        2 : "python_targets_" + options['python3'],
        3 : "python_targets_" + options['python2'] + " python_targets_" + options['python3'],
        5 : "python_single_target_" + options['python2'] + " python_targets_" + options['python2'],
        6 : "python_single_target_" + options['python3'] + " python_targets_" + options['python3'],
    }
    res = open('/etc/portage/package.use/gen-python', 'w')
    res.write('# This file was auto generated''\n')
    res.write('#   based on file /etc/portage/d.gen/package.use/python''\n\n')
    for package, flags in packages.items():
        if flags in output:
            res.write(package + ' ' + output[flags] + '\n')
        elif flags == 0:
            res.write('# ' + package + ' is unset''\n')
        else:
            res.write('#' + package)
            print('bad flags', flags, 'for package', package)
    res.close()

def regular_gen(input_path, output_path):
    print('generating "' + output_path + '"')

    res = open(output_path, 'w')
    res.write('# This file was auto generated''\n')
    res.write('#   based on file ' + input_path + '\n\n')

    options = {}
    for line in open(input_path, 'r'):
        line = line.strip()
        if len(line) == 0 or line[0] == '#': continue
        if line[0] == '!':
            key, value = line[1:].split('=', 1)
            options[key.strip()] = value.strip()
        else:
            for opt in options:
                line = line.replace('${' + opt + '}', options[opt])
            res.write(line + '\n')
    res.close()

if __name__ == "__main__":
    use_python_gen()
    #regular_gen('/etc/portage/d.gen/package.accept_keywords/qt', '/etc/portage/package.accept_keywords/gen-qt')
