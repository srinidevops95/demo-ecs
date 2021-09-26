provider "aws" {
        region="us-east-1"
}


resource "aws_ecr_repository" "my_repo" {
  name                 = "my-ecs-repo"
  image_tag_mutability = "MUTABLE"
}


#######
resource "aws_ecr_lifecycle_policy" "my_repo_policy" {
  repository = aws_ecr_repository.my_repo.name

  policy = jsonencode({
   rules = [{
     rulePriority = 1
     description  = "keep last 10 images"
     action       = {
       type = "expire"
     }
     selection     = {
       tagStatus   = "any"
       countType   = "imageCountMoreThan"
       countNumber = 10
     }
   }]
  })
}
