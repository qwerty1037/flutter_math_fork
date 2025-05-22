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
  List<EquationRowNode> _elementBreak(List<GreenNode> list) {
    return list
        .where((element) => !(element is TransparentNode))
        .expand((element) {
      if (element is EquationRowNode) {
        return _elementBreak(element.flattenedChildList);
      }
      return [element.wrapWithEquationRow()];
    }).toList();
  }

  BreakResult<EquationRowNode> elementBreak() {
    return BreakResult<EquationRowNode>(
      parts: _elementBreak(flattenedChildList),
      penalties: [10000],
    );
  }
}
