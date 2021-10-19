// pathの設定
const path = require('path');
// main.cssをoutputに書き出すプラグイン
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
// index.htmlをoutputに書き出すプラグイン
const HtmlWebpackPlugin = require('html-webpack-plugin');
//  ビルドの際outputディレクトリのファイル・フォルダを削除するプラグイン
const { CleanWebpackPlugin } = require('clean-webpack-plugin');

module.exports = {
  // エントリーの設定
  entry: './src/frontend/packs/hello_vue.js',
  // アウトプットの設定
  output: {
    path: path.resolve(__dirname, './dist'),
    filename: 'frontend/packs/hello_vue.js'
  },
  module: {
    rules: [
      {
        test: /\.(css|scss|sass)/,
        use: [
          {
            loader: MiniCssExtractPlugin.loader,
          },
          {
            loader: 'css-loader',
          },
          {
            loader: 'sass-loader',
          },
        ],
      },
      {
        test: /\.pug/,
        use: [
          {
            loader: 'html-loader',
          },
          {
            loader: 'pug-html-loader',
            options: {
              pretty: true,
            },
          },
        ],
      },
    ],
  },
  plugins: [
    // html,cssのファイルの数だけnewで作り、template,filenameを設定する
    // cssファイルをoutput先へ別ファイルとして書き出す
    new MiniCssExtractPlugin({
      filename: './stylesheets/[name].css',
    }),
    new HtmlWebpackPlugin({
      // templateで指定したファイルを元にhtmlwebpackpluginがoutputにHTMLフォルダを生成する。
      template: './src/templates/index.pug',
      filename: 'index.html',
    }),
    new CleanWebpackPlugin(),
  ],
}