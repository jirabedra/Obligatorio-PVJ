let project = new Project('Clase1');
project.addAssets('Assets/**');
project.addShaders('Shaders/**');
project.addSources('Sources');

project.addDefine('debugInfo');


await project.addProject('khawy');

resolve(project);
