defmodule TreeNode do
  defstruct val: nil,
            left: nil,
            right: nil

  def new(val, left \\ nil, right \\ nil) do
    %__MODULE__{val: val, left: left, right: right}
  end

  def binary_tree_compare(a, b) when is_nil(a) or is_nil(b) do
    a == b
  end

  def binary_tree_compare(a, b) do
    a.val == b.val &&
      binary_tree_compare(a.left, b.left) &&
      binary_tree_compare(a.right, b.right)
  end

  def tree_to_string(tree) do
    tree
    |> to_list()
    |> Enum.join(",")
  end

  def to_list(tree) do
    reduce(tree, fn v, acc -> [v | acc] end, [])
  end

  def reduce(nil, _f, acc), do: acc

  def reduce(%{val: val, left: left, right: right}, f, acc) do
    acc = reduce(left, f, f.(val, acc))
    reduce(right, f, acc)
  end

  def render(a, b) do
    canvas_id_a = Enum.random(10..100)
    canvas_id_b = Enum.random(10..100)

    """
    <LOG:HTML:><div style="display:flex;align-items:flex-start;"><canvas id="bt-#{canvas_id_a}"></canvas><canvas id="bt-#{
      canvas_id_b
    }"></canvas></div><script> (function draw() { class TreeNode { constructor(val, left, right) { this.val = val; this.left = left; this.right = right; } } const treeHeight = (root, height=0) => root ? 1 + Math.max( treeHeight(root.left, height), treeHeight(root.right, height) ) : height ; const drawBinaryTree = (root, ctx, canvas, size=15) => { let depth = treeHeight(root); let level = []; let x = size; let y = size * 2; const q = [[root, depth, null]]; canvas.width = 2 ** depth * size + size * 2; canvas.height = depth * size * 4; ctx.textAlign = "center"; ctx.textBaseline = "middle"; ctx.strokeStyle = "#666"; ctx.lineWidth = 2; while (depth >= 0) { const [currNode, currDepth] = q.shift(); if (currDepth < depth) { depth = currDepth; x += 2 ** depth * size; for (const node of level) { if (node) { ctx.lineWidth = 1; if (node.left) { ctx.beginPath(); ctx.moveTo(x + 1, y + 1); ctx.lineTo(x - 2 ** (depth + 1) * size / 4, y + size * 4 - 1); ctx.stroke(); } if (node.right) { ctx.beginPath(); ctx.moveTo(x + 1, y + 1); ctx.lineTo(x + 2 ** (depth + 1) * size / 4, y + size * 4 - 1); ctx.stroke(); } ctx.lineWidth = 2; ctx.beginPath(); ctx.arc(x + 1, y + 1, size - 2, 0, 2 * Math.PI); ctx.stroke(); ctx.fillStyle = "#fff"; ctx.fill(); ctx.fillStyle = "#000"; ctx.font = (size - ("" + node.val).length) + "px Courier New"; ctx.fillText(node.val, x + 1, y + 1); } x += 2 ** (depth + 1) * size; } x = size; y += size * 4; level = []; } if (currNode) { level.push(currNode); q.push([currNode.left, depth - 1]); q.push([currNode.right, depth - 1]); } else { level.push(null); q.push([null, depth - 1]); q.push([null, depth - 1]); } } }; const treeFromString = s => { const treeArray = s .replace(/[[|]]/g, "") .split(",") .map(e => /(null)|(nil)/ig.test(e) ? null : e.trim()) ; treeArray.unshift(null); const root = new TreeNode(treeArray[1]); treeFromArray(root, treeArray); return treeArray.length > 1 && treeArray[1] ? root : null; }; const treeFromArray = (root, a, i=1) => { if (root && i < a.length) { if (a[i*2]) { root.left = new TreeNode(a[i*2]); treeFromArray(root.left, a, i * 2); } if (a[i*2+1]) { root.right = new TreeNode(a[i*2+1]); treeFromArray(root.right, a, i * 2 + 1); } } }; const canvasA = document.querySelector("#bt-" + "#{
      canvas_id_a
    }"); drawBinaryTree( treeFromString("#{tree_to_string(a)}"), canvasA.getContext("2d"), canvasA ); const canvasB = document.querySelector("#bt-" + "#{
      canvas_id_b
    }"); drawBinaryTree( treeFromString("#{tree_to_string(b)}"), canvasB.getContext("2d"), canvasB ); })(); </script>
    """
  end
end
