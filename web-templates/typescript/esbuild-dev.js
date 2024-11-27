import * as esbuild from 'esbuild';
// import _default from 'esbuild-plugin-css-modules';
// import cssImportPlugin from '@chialab/esbuild-plugin-css-import';

esbuild.build({
  entryPoints: ['js/index.ts', 'index.css'],
  bundle: true,
  sourcemap: true,
  outdir: 'dist',
  target: 'es2016',
  entryNames: '[name]',
  external: ['leaflet', 'mithril', 'geojson']
}).catch((error) => { 
  console.error(error);
  process.exit(1);
});
