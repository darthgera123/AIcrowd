module.exports = {
  test: /ckeditor5-[^\/\\]+[\/\\].+\.js$/,
  use: [
    {
      loader: 'babel-loader',
      options: {
        presets: [['@babel/preset-env', require('@babel/preset-env')]]
      }
    }
  ]
}
