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