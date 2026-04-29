import '../models/models.dart';

class MockData {
  static final List<Skill> allSkills = [
    Skill(id: '1', name: 'Python', category: 'Programming'),
    Skill(id: '2', name: 'JavaScript', category: 'Programming'),
    Skill(id: '3', name: 'React', category: 'Web Development'),
    Skill(id: '4', name: 'Flutter', category: 'Mobile Development'),
    Skill(id: '5', name: 'Dart', category: 'Programming'),
    Skill(id: '6', name: 'UI/UX Design', category: 'Design'),
    Skill(id: '7', name: 'Figma', category: 'Design'),
    Skill(id: '8', name: 'SQL', category: 'Database'),
    Skill(id: '9', name: 'Machine Learning', category: 'Data Science'),
    Skill(id: '10', name: 'Data Visualization', category: 'Data Science'),
    Skill(id: '11', name: 'Node.js', category: 'Web Development'),
    Skill(id: '12', name: 'Cloud Computing', category: 'DevOps'),
    Skill(id: '13', name: 'Cybersecurity', category: 'Security'),
    Skill(id: '14', name: 'Communication', category: 'Soft Skills'),
    Skill(id: '15', name: 'Project Management', category: 'Business'),
  ];

  static final List<String> interests = [
    'Artificial Intelligence',
    'Mobile Apps',
    'Web Development',
    'Game Development',
    'Cybersecurity',
    'Data Science',
    'Cloud Systems',
    'Digital Marketing',
    'Product Management',
    'Financial Tech',
  ];

  static final List<Mentor> mentors = [
    Mentor(
      id: 'm1',
      name: 'Alex Rivera',
      role: 'Senior Software Engineer',
      company: 'Google',
      avatarUrl: 'https://i.pravatar.cc/150?u=m1',
    ),
    Mentor(
      id: 'm2',
      name: 'Sarah Chen',
      role: 'Product Designer',
      company: 'Airbnb',
      avatarUrl: 'https://i.pravatar.cc/150?u=m2',
    ),
    Mentor(
      id: 'm3',
      name: 'David Kumar',
      role: 'Data Science Lead',
      company: 'Meta',
      avatarUrl: 'https://i.pravatar.cc/150?u=m3',
    ),
  ];

  static final List<Career> careers = [
    Career(
      id: 'c1',
      title: 'Full Stack Developer',
      description: 'Build complete web applications from frontend to backend.',
      requiredSkills: ['JavaScript', 'React', 'Node.js', 'SQL', 'Python'],
      demand: JobDemand.high,
      salaryRange: '\$80k - \$150k',
      growthTrend: '+25% Growth',
      whyThisCareer: 'Full Stack Developers are highly versatile and in constant demand across startups and big tech. You get to build end-to-end solutions.',
      mentors: [mentors[0]],
      dayInLife: 'Morning stand-up, coding new features, reviewing PRs, and debugging production issues.',
    ),
    Career(
      id: 'c2',
      title: 'AI/ML Engineer',
      description: 'Develop intelligent systems and predictive models.',
      requiredSkills: ['Python', 'Machine Learning', 'Data Visualization', 'SQL', 'Math'],
      demand: JobDemand.high,
      salaryRange: '\$110k - \$190k',
      growthTrend: '+40% Growth',
      whyThisCareer: 'AI is transforming every industry. As an ML engineer, you are at the forefront of the next technological revolution.',
      mentors: [mentors[2]],
      dayInLife: 'Data cleaning, training neural networks, optimizing model performance, and researching new algorithms.',
    ),
    Career(
      id: 'c3',
      title: 'Mobile App Developer',
      description: 'Create high-performance apps for iOS and Android.',
      requiredSkills: ['Flutter', 'Dart', 'UI/UX Design', 'JavaScript', 'Cloud Computing'],
      demand: JobDemand.medium,
      salaryRange: '\$90k - \$140k',
      growthTrend: '+18% Growth',
      whyThisCareer: 'The mobile-first world means businesses need high-quality mobile experiences. Flutter allows for beautiful, fast development.',
      mentors: [mentors[0], mentors[1]],
      dayInLife: 'Building UI components, integrating APIs, optimizing performance, and testing on different devices.',
    ),
  ];

  static CareerRoadmap getMockRoadmap(String careerId, String careerTitle) {
    return CareerRoadmap(
      careerId: careerId,
      careerTitle: careerTitle,
      months: [
        RoadmapMonth(month: 1, tasks: [
          RoadmapTask(id: 't1', title: 'Master the basics of Programming'),
          RoadmapTask(id: 't2', title: 'Set up development environment'),
          RoadmapTask(id: 't3', title: 'Complete HTML/CSS Bootcamp'),
        ]),
        RoadmapMonth(month: 2, tasks: [
          RoadmapTask(id: 't4', title: 'Advanced JavaScript Concepts'),
          RoadmapTask(id: 't5', title: 'Build a small portfolio project'),
          RoadmapTask(id: 't6', title: 'Introduction to Frameworks'),
        ]),
        RoadmapMonth(month: 3, tasks: [
          RoadmapTask(id: 't7', title: 'Database management essentials'),
          RoadmapTask(id: 't8', title: 'API Integration patterns'),
          RoadmapTask(id: 't9', title: 'Deployment and CI/CD basics'),
        ]),
      ],
    );
  }
}
