import 'package:flutter_math_fork/src/ast/tex_break.dart';

import 'syntax_tree.dart';

extension SyntaxTreeElementStyleBreakExt on SyntaxTree {
  BreakResult<SyntaxTree> elementBreak() {
    final eqRowBreakResult = greenRoot.elementBreak();
    return BreakResult(
      parts: eqRowBreakResult.parts
          .map((part) => SyntaxTree(greenRoot: part))
          .toList(growable: false),
      penalties: [10000],
    );
  }
}

extension EquationRowNodeElementStyleBreakExt on EquationRowNode {
  BreakResult<EquationRowNode> elementBreak() {
    return BreakResult<EquationRowNode>(
      parts: flattenedChildList
          .map((element) => element.wrapWithEquationRow())
          .toList(),
      penalties: [10000],
    );
  }
}
