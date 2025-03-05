#!/usr/bin/bash

function create_package()
{
  Rscript -e 'library(usethis);create_package("pQTLdata");use_mit_license()'
}

function create_github_repository()
{
  export user=jinghuazhao
  export token=$(awk "NR==2" ~/doc/access)
  export API=https://api.github.com
  export header="Accept: application/vnd.github.v3+json"
  export name=pQTLdata

# 1. create the repository
  curl -X POST -u $user:$token -H "$header" -d '{"name": "'"$name"'"}' $API/user/repos

# 2. list the repository
  curl -H "$header" $API/repos/$user/$name

# 3. delete the repository
# curl -X DELETE -u $user:$token -H "$header" $API/repos/$user/$name

# 4. customise settings and commit
  git config --global user.email "jinghuazhao@hotmail.com"
  git config --global user.name "jinghuazhao@github.com"
  git config --global url."https://jinghuazhao@github.com".insteadOf "https://github.com"
  git init
  git branch -M main
  git remote add origin git@github.com:jinghuazhao/pQTLdata.git
  git push --set-upstream origin main

# 5. pkgdown site
  Rscript -e '
      library(pkgdown)
      init_site()
      devtools::document()
      build_site()
  '
}

# 6. automate commitments

module load ceuadmin/R
Rscript -e 'knitr::knit("README.Rmd");devtools::document();pkgdown::build_site()'

for d in pQTLdata
do
    if [ -d vignettes/${d} ]; then
       rm -rf docs/articles/${d}
       mv vignettes/${d} docs/articles/
    fi
done

for f in .gitignore .Rbuildignore .Rinstignore docs/ pkgdown/ \
         data/ DESCRIPTION INDEX inst/ LICENSE LICENSE.md man/ vignettes/ \
         NAMESPACE NEWS.md R/ README.*
do
  echo adding ${f}
  git add ${f}
  git commit -m "${f}"
done
git push
du -h --exclude .git --exclude docs
