// decorate your test like so
[Theory]
[Repeat(10)]

// And put an integer argument to it (int itNumber)

public sealed class RepeatAttribute : DataAttribute
{
    private readonly int _count;

    public RepeatAttribute(int count)
    {
        const int minimumCount = 1;
        if (count < minimumCount)
        {
            throw new ArgumentOutOfRangeException(
                paramName: nameof(count),
                message: "Repeat count must be greater than 0.");
        }
        _count = count;
    }

    public override IEnumerable<object[]> GetData(MethodInfo testMethod)
    {
        foreach (var iterationNumber in Enumerable.Range(start: 1, count: _count))
        {
            yield return new object[] { iterationNumber };
        }
    }
}

(ITestOutputHelper output)
{
    _writer = new TestOutputWriter(output);
    _writer.WriteLine("In PostgresEventStoreTests");

    var type = output.GetType();
    var testMember = type.GetField("test", BindingFlags.Instance | BindingFlags.NonPublic);
    var test = (ITest)testMember.GetValue(output);
    _writer.WriteLine($"Test name: {test}");

public class TestOutputWriter
{
    private readonly ILogger _logger;

    public TestOutputWriter(ITestOutputHelper outputHelper)
    {
        XUnitOutputHelper = outputHelper;
        _logger = new LoggerConfiguration().WriteTo.File("ci.log").CreateLogger();
    }

    public ITestOutputHelper XUnitOutputHelper { get; }

    public void WriteLine(string line)
    {
        _logger.Information(line);
        XUnitOutputHelper.WriteLine(line); // for VS
        Console.WriteLine(line); // for docker
    }
}