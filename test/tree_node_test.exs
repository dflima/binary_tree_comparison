defmodule TreeNodeTest do
  use ExUnit.Case
  doctest TreeNode

  describe "Test Binary Tree Compare" do
    setup do
      a = TreeNode.new(1)
      aa = TreeNode.new(1)
      b = TreeNode.new(2)
      c = TreeNode.new(3, a, aa)
      cc = TreeNode.new(3, a, a)
      d = TreeNode.new(3, a, b)
      e = TreeNode.new(4, a, b)
      left = TreeNode.new(0, TreeNode.new(1, TreeNode.new(2)))
      right = TreeNode.new(0, nil, TreeNode.new(1, nil, TreeNode.new(2)))
      zig_zag = TreeNode.new(0, nil, TreeNode.new(1, TreeNode.new(2)))
      zag_zig = TreeNode.new(0, TreeNode.new(1, nil, TreeNode.new(2)))

      {:ok,
       %{
         a: a,
         aa: aa,
         b: b,
         c: c,
         cc: cc,
         d: d,
         e: e,
         left: left,
         right: right,
         zig_zag: zig_zag,
         zag_zig: zag_zig
       }}
    end

    test "should return true for equal nodes", %{a: a, aa: aa, c: c, cc: cc} do
      Enum.each(
        [[a, aa], [nil, nil], [c, c], [c, cc]],
        fn [a, b] ->
          TreeNode.render(a, b)
          assert TreeNode.binary_tree_compare(a, b) == true
        end
      )
    end

    test "should return false for nonequal nodes", %{a: a, b: b} do
      Enum.each(
        [[a, b], [a, nil]],
        fn [a, b] ->
          if TreeNode.binary_tree_compare(a, b) do
            TreeNode.render(a, b)
            assert true == false
          end
        end
      )
    end

    test "should return true for equal trees", %{
      left: left,
      right: right,
      zig_zag: zig_zag,
      zag_zig: zag_zig
    } do
      Enum.each([[left, left], [right, right], [zig_zag, zig_zag], [zag_zig, zag_zig]], fn [a, b] ->
        unless TreeNode.binary_tree_compare(a, b) do
          TreeNode.render(a, b)
          assert false == true
        end
      end)
    end
  end
end
