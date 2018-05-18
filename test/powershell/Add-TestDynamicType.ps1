Add-Type -TypeDefinition @'
using System.Collections.Generic;
using System.Dynamic;

public class TestDynamic : DynamicObject
{
    public TestDynamic() { }

    public override IEnumerable<string> GetDynamicMemberNames()
    {
        return new string[] { "FooProp", "BarProp" };
    }

    public override bool TryGetMember(GetMemberBinder binder, out object result)
    {
        if (binder.Name == "FooProp")
        {
            result = 123;
            return true;
        }
        else if (binder.Name == "BarProp")
        {
            result = 456;
            return true;
        }
        else if (binder.Name == "HiddenProp") // Not presented in GetDynamicMemberNames
        {
            result = 789;
            return true;
        }

        result = null;
        return false;
    }
}
'@
