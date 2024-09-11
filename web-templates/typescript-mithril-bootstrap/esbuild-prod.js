import * as esbuild from 'esbuild';

esbuild.build({
  entryPoints: ['js/index.ts', 'index.css'],
  bundle: true,
  minify: true,
  outdir: 'dist',
  target: 'es2016',
  entryNames: '[name]',
  external: ['leaflet', 'mithril', 'geojson']
}).catch((error) => { 
  console.error(error);
  process.exit(1);
});