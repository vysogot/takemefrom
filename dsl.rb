# frozen_string_literal: true

# require 'rspec/autorun'

Node = Struct.new(:id, :content)
Edge = Struct.new(:id, :source, :target, :content)

class DSL
  def self.eval(str)
    new.tap do |instance|
      instance.instance_eval(str)
    end
  end

  def result
    {
      nodes: @nodes.map do |n|
        {
          data: {
            id: n.id,
            content: n.content
          }
        }
      end,
      edges: @edges.map do |n|
        {
          data: {
            id: n.id,
            content: n.content,
            source: n.source,
            target: n.target
          }
        }
      end
    }
  end

  def self.run(&block)
    new.tap do |instance|
      instance.instance_eval(&block)
    end
  end

  private

  def initialize
    @nodes_env = {}
    @nodes = []
    @edges = []
  end

  def node(name, content)
    node = Node.new(name, content)
    @nodes_env[name] = node
    @nodes << node
  end

  def connect(name1, name2, content)
    node1 = @nodes_env.fetch(name1) { raise "#{name1} is not defined" }
    node2 = @nodes_env.fetch(name2) { raise "#{name2} is not defined" }

    edge = Edge.new('edge#1', node1.id, node2.id, content)
    @edges << edge
  end
end

require 'json'

puts (DSL.eval ARGV[0]).result.to_json

# RSpec.describe 'my dsl' do
#   it 'allows to define nodes' do
#     result = DSL.run do
#       node :my_node, 'Something'
#       node :my_node1, 'Something'
#       connect :my_node, :my_node1, 'This is the answer'
#     end.result
#     expect(result).to eq(edges: [{ data: { content: 'This is the answer', id: 'edge#1', source: :my_node, target: :my_node1 } }],
#                          nodes: [{ data: { content: 'Something', id: :my_node } }, { data: { content: 'Something', id: :my_node1 } }])
#   end

#   it 'allows to define nodes' do
#     result = DSL.eval(%Q{
#       node :my_node, 'Something'
#       node :my_node1, 'Something'
#       connect :my_node, :my_node1, 'This is the answer'
#     }).result
#     expect(result).to eq(edges: [{ data: { content: 'This is the answer', id: 'edge#1', source: :my_node, target: :my_node1 } }],
#                          nodes: [{ data: { content: 'Something', id: :my_node } }, { data: { content: 'Something', id: :my_node1 } }])
#   end
# end
