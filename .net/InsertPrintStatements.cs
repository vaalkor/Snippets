public void InsertConsoleStatements()
{
    var globalCount = 0;
    var folder = "some_folder";
    var files = Directory.GetFiles(folder, "*.cs", SearchOption.AllDirectories);

    foreach (var file in files)
    {
        var text = File.ReadAllText(file);
        var ast = SyntaxFactory.ParseSyntaxTree(text);
        var statements = ast.GetRoot().DescendantNodes().Where(x =>
        {
            return x is StatementSyntax && x is not BlockSyntax;
        }).ToList();

        var offset = 0;
        foreach (var statement in statements)
        {
            var printStatementText = $"System.Console.WriteLine(\"ROBDEBUG: {globalCount}\");\r\n";
            text = text.Insert(statement.FullSpan.Start + offset, printStatementText);
            offset += printStatementText.Length;
            globalCount++;
        }
        File.WriteAllText(file, text);
    }
}