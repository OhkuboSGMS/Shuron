# 動作確認・考察 {#evaluation}
本章では,
4章で述べた実装手法によって作成されたsmm2Builderの動作確認について述べる.
[@sec:check]では，動作確認について，
[@sec:consideration]では，さらなる機能について考察する.

## 動作確認 {#sec:check}

本節では,実装を行ったsmm2Builderの動作確認を行う

評価環境を[@tbl:test-env]に示す.

| ソフトウェア | バージョン|
| ---        | -----    |
| Ubuntu     |  16.04   |
| python     |    3.69   |
| numpy      |     1.16.5  |
| pytorch    |  1.2.0    |
| CUDA | 10.0|
| Nintendo Switch | 9.1.0|

:評価環境 {#tbl:test-env}

生成モデルはDeep Convolutional GAN(以下DCGANとConditional GAN[@cGAN]を組み合わせたGANを用いて学習,生成を行った.
[@fig:ganGenerator;@fig:ganDiscriminator]にモデルの構造を示す.

![Generatorの構造](img/GeneratorArch.png){#fig:ganGenerator}


![Discriminatorの構造](img/DiscriminatorArch.png){#fig:ganDiscriminator}

Generatorの転置畳み込み層とDiscriminatorの畳み込み層
の各層間には,最後の層を除いてBatchNorm,LeakyReluが挿入されている.


次に取得したデータセットについて述べる.
smm2から取得したデータセットは総数が3531レベルで,ステージを分割した結果の数は31644である.
これを使用して学習を行った.


学習の際のハイパーパラメータとしてバッチサイズを32,学習率を0.00001,エポック数を500,Generatorの潜在変数を20
とした.




BCDファイルからJsonへの変換の動作確認を行う.
まず,変換する元のBCDファイルのゲーム上での配置を表す図を[@fig:originalStage]に示す.

![実際の配置画面](img/originalStage.png){#fig:originalStage}


次に
[@fig:bcd2json]にBCDファイルからJson形式への変換の結果を示す.
JsonのTilesデータは同様のオブジェクトが表示されるため一部省略した.


![BCDファイルから変換したJson形式のレベル](img/bcd2Json){#fig:bcd2json}

[@fig:bcd2json]よりBCDファイルからJson形式に変換できることが確認できた.

次に,Json形式から画像への変換の動作確認を行う.
[@fig:renderStage]にJsonから画像にしたレベルを示す.
[@fig:renderStage]は表示できるレベル全体を表示するため,オブジェクトが配置されている部分を
拡大して示している.



![smm2Builderからの画像出力](img/course_data_007.png){#fig:renderStage}

[@fig:originalStage;@fig:renderStage]よりコンソールと同等の表示ができることが確認できた.

[@tbl:hyperparm]および[@fig:ganGenerator:@fig:ganDiscriminator]
を用いて前述のデータセットを用いて学習を行った.

学習後のレベルの出力のサンプルを画像を変換した結果を[@fig:generatedLevel]に示す.
さらに,出力をBCDに変換し,コンソールで読み込ませたレベルのスクリーンショットの合成を
[@fig:consoleGeneratedLevel]に示す.

<!--
![生成モデルからの出力の画像変換](img/generatedLevel.png){#fig:generatedLevel}
![生成モデルからの出力のコンソールによる表示](img/generateLevelConsole.png){#fig:consoleGeneratedLevel}

-->
\begin{figure}
    \hypertarget{fig:generatedLevel}{%
    \centering
    \includegraphics[angle=90,scale=1.5]{img/generatedLevel.png}
    \caption{生成モデルからの出力の画像変換}\label{fig:generatedLevel}
    }
\end{figure}

\begin{figure}
    \hypertarget{fig:consoleGeneratedLevel}{%
    \centering
    \includegraphics[angle=90,scale=1.5]{img/generateLevelConsole.png}
    \caption{生成モデルからの出力のコンソールによる表示}\label{fig:consoleGeneratedLevel}
    }
\end{figure}

\newpage

以上より4章で定義した動作を実際確認することができた.


## 考察 {#sec:consideration}
本節では使用したデータセットに関する考察,より生成したレベルの精度の向上の考察について
行う.

本論文で学習に使用したデータセットはステージを分割したときのレベルのインデックスラベル以外の
他のラベルは使用しなかったが実際にはステージごとにタグ,遊ばれた回数,難しさ
などのアノテーションがレベルごとに存在するためこのアノーテーションを学習時に
付加することでより特定のカテゴリ,難易度にマッチした生成が可能になると考えられる.
[@fig:levelAnnotation1;@fig:levelAnnotation2]にゲームタグごとのレベルの検索画面を示す.

![レベルのアノテーションの検索画面1](img/levelAnnotation1.jpg){#fig:levelAnnotation1}

![レベルのアノテーションの検索画面2](img/levelAnnotation2.jpg){#fig:levelAnnotation2}


学習後に生成したレベルを実際にプレイした結果としてゲームとして成立するステージは多くなかった.
これの原因について考察する.

smm2には単純にプレイヤがゴールを目指すステージだけではなく[@fig:levelAnnotation2]音楽タグやオートマリオタグのように効果音ブロックを使った
音楽を奏でるレベルやプレイヤを操作せずに自動でレベルのオブジェクトによってゲームが進行するレベルなども存在するため,
学習に使用するレベルをフィルタリングする必要があると考えられる.

[@fig:levelHist1;@fig:levelHist2;@fig:levelHist3]に各レベルごとに使用されているオブジェクトのヒストグラムを表示する.

![レベルごとのオブジェクトのヒストグラム1](img/allHist1.png){#fig:levelHist1}

![レベルごとのオブジェクトのヒストグラム2](img/allHist2.png){#fig:levelHist2}

![レベルごとのオブジェクトのヒストグラム3](img/allHist3.png){#fig:levelHist3}


[@fig:levelHist3]の$ice\char`_block$などのオブジェクトにおいて頻度が特に高いレベルが存在する.これらのレベル
は学習をする上である特定のカテゴリに特化したレベルである可能性があるため該当のレベルをフィルタリングをするとより良い結果が得られるのではないかと考える.

また,smm2Builderが今回使用可能なオブジェクト数が実際のレベルで使用可能なオブジェクト数と比べ少ないため実装するオブジェクト数を
増やすことで学習するレベルの正確性が向上するためより正確なレベルが生成できるようになると考える.

<!--生成したステージはプレイ可能かどうかの判定を本論文ではしていないため強化学習を用いてプレイ可能なエージェントを訓練させて
プレイさせることで生成したステージのプレイの可否を判定できより生成モデルの向上に役立つと考える. -->
