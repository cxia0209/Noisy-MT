# Neural Machine Translation withPluggable Denoise Function

Brief Introduction

- In this project, we propose a method that lets us use pretrained neural machinetranslation model, and then by only adding a denoise function, the nmt modelcould normalize the text, and translate the text as the clean data. Also, we reducethe large number of parameters needed to re-train a denoise nmt model by fix allthe parameters except for the denoise function itself. By reducing the parameters,we achieve the same BLEU score as naive domain adapation which fine-tunes thewhole model on MTNT dataset.
