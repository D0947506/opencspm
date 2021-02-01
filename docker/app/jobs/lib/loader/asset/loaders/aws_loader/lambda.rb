# frozen_string_literal: true

#
# Load Lambda assets into RedisGraph
#
# Each method returns an array of Cypher queries
#
class AWSLoader::Lambda < GraphDbLoader
  def function
    node = 'AWS_LAMBDA_FUNCTION'
    q = []

    # function node
    q.push(_upsert({ node: node, id: @name }))

    # vpc
    q.push(_append({ node: node, id: @name, data: {
                     vpc_id: @data&.vpc_config&.vpc_id || 'none'
                   } }))

    # TODO: map to IAM_ROLE (assumes role)
    # TODO: map to AWS_VPC
    # TODO: map to AWS_SUBNET
    # TODO: map to AWS_SECURITY_GROUP

    q
  end

  def layer
    node = 'AWS_LAMBDA_LAYER'
    q = []

    # layer node
    q.push(_upsert({ node: node, id: @name }))

    # TODO: map to AWS_LAMBDA_FUNCTION

    q
  end
end
