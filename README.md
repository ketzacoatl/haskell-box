## Haskell Box

An IDE for [Haskell](https://haskell-lang.org) that uses emacs,
[Stack](https://haskellstack.org/),
[Intero](https://github.com/commercialhaskell/intero),
and [hindent](https://github.com/commercialhaskell/hindent).


### Get the Box

```
ᐅ mkdir ~/.haskell-box
ᐅ wget -q -O ~/.haskell-box/box-vim.el https://raw.githubusercontent.com/ketzacoatl/haskell-box/master/box-vim.el
```


### Start the Box

```
ᐅ emacs -q -l ~/.haskell-box/box-vim.el
```

You might want to add a shell `alias`, for example:

```sh
alias hbox="emacs -q -l ~/.haskell-box/box-vim.el"
```


### Be Productive

